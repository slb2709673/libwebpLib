#
# Be sure to run `pod lib lint libwebp-repo.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'libwebpLib'
  s.version          = '1.0.0'
  s.summary          = 'Library to encode and decode images in WebP format'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
  Library to encode and decode images in WebP format
                       DESC

  s.homepage         = 'https://github.com/slb2709673/libwebpLib'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'BSD', :file => 'LICENSE' }
  s.author           = 'Google Inc.'
  s.source           = { :git => 'https://github.com/slb2709673/libwebpLib.git', :tag => "v#{s.version}" }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.compiler_flags  = '-D_THREAD_SAFE'
  s.requires_arc = false
  
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.8'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.prepare_command = "sed -i.bak 's/<inttypes.h>/<stdint.h>/g' 'libwebpLib/Classes/libwebp/webp/types.h'"
  s.preserve_paths = 'src'
  s.pod_target_xcconfig = {"USER_HEADER_SEARCH_PATHS" => "$(inherited) ${PODS_ROOT}/libwebp/ ${PODS_TARGET_SRCROOT}/"}

  # s.source_files = 'libwebp-repo/Classes/**/*'


  s.subspec 'webp' do |sub|
    sub.header_dir = 'webp'
    sub.source_files = "src/webp/decode.h", "src/webp/encode.h", "src/webp/types.h", "src/webp/mux_types.h", "src/webp/format_constants.h", "src/utils/*.{h,c}", "src/dsp/*.{h,c}", "src/dec/*.{h,c}", "src/enc/*.{h,c}"
    sub.public_header_files = "src/webp/decode.h", "src/webp/encode.h", "src/webp/types.h", "src/webp/mux_types.h", "src/webp/format_constants.h"
  end

  s.subspec 'demux' do |sub|
    sub.source_files = 'src/demux/*.{h,c}'
    sub.dependency 'libwebp/webp'
    source_files = 'src/demux/*.{h,c}', 'src/webp/demux.h'
    public_header_files = 'src/webp/demux.h'
  end

  s.subspec 'mux' do |sub|
      sub.source_files = 'src/mux/*.{h,c}'
      sub.dependency 'libwebp/demux'
      source_files = 'src/mux/*.{h,c}', 'src/webp/mux.h'
      public_header_files = 'src/webp/mux.h'
  end
  # s.resource_bundles = {
  #   'libwebp-repo' => ['libwebp-repo/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
