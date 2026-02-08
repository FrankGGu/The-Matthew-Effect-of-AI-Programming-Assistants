#include <string>
#include <vector>
#include <unordered_map>
#include <algorithm> // For std::max

class Solution {
public:
    std::vector<std::vector<std::string>> mostPopularCreator(std::vector<std::string>& creators, std::vector<std::string>& videoIds, std::vector<int>& views) {
        std::unordered_map<std::string, long long> creatorTotalViews;
        std::unordered_map<std::string, std::pair<int, std::string>> creatorBestVideo; // {max_views, video_id}

        long long maxOverallViews = 0;

        for (int i = 0; i < creators.size(); ++i) {
            const std::string& creator = creators[i];
            const std::string& videoId = videoIds[i];
            int viewCount = views[i];

            creatorTotalViews[creator] += viewCount;

            if (creatorBestVideo.find(creator) == creatorBestVideo.end()) {
                creatorBestVideo[creator] = {viewCount, videoId};
            } else {
                if (viewCount > creatorBestVideo[creator].first) {
                    creatorBestVideo[creator] = {viewCount, videoId};
                } else if (viewCount == creatorBestVideo[creator].first) {
                    if (videoId < creatorBestVideo[creator].second) {
                        creatorBestVideo[creator].second = videoId;
                    }
                }
            }
        }

        for (const auto& pair : creatorTotalViews) {
            maxOverallViews = std::max(maxOverallViews, pair.second);
        }

        std::vector<std::vector<std::string>> result;
        for (const auto& pair : creatorTotalViews) {
            if (pair.second == maxOverallViews) {
                result.push_back({pair.first, creatorBestVideo[pair.first].second});
            }
        }

        return result;
    }
};