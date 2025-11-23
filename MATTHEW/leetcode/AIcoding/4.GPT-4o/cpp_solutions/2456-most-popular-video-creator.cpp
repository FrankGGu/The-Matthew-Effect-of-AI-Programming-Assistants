#include <vector>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> mostPopularCreator(vector<string>& creators, vector<string>& ids, vector<int>& views) {
        unordered_map<string, long long> creatorViews;
        unordered_map<string, string> creatorBestVideo;
        unordered_map<string, long long> maxViews;

        for (int i = 0; i < creators.size(); ++i) {
            creatorViews[creators[i]] += views[i];
            if (creatorBestVideo.find(creators[i]) == creatorBestVideo.end() || 
                views[i] > maxViews[creatorBestVideo[creators[i]]]) {
                creatorBestVideo[creators[i]] = ids[i];
                maxViews[ids[i]] = views[i];
            } else if (views[i] == maxViews[creatorBestVideo[creators[i]]]) {
                if (ids[i] < creatorBestVideo[creators[i]]) {
                    creatorBestVideo[creators[i]] = ids[i];
                }
            }
        }

        long long maxTotalViews = 0;
        for (const auto& [creator, totalViews] : creatorViews) {
            maxTotalViews = max(maxTotalViews, totalViews);
        }

        vector<vector<string>> result;
        for (const auto& [creator, totalViews] : creatorViews) {
            if (totalViews == maxTotalViews) {
                result.push_back({creator, creatorBestVideo[creator]});
            }
        }

        return result;
    }
};