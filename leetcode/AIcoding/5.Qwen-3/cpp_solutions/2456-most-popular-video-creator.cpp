#include <iostream>
#include <vector>
#include <map>
#include <string>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> mostPopularVideo(vector<string>& creators, vector<string>& ids, vector<int>& views) {
        map<string, pair<int, string>> videoMap;
        map<string, int> countMap;

        for (int i = 0; i < creators.size(); ++i) {
            string creator = creators[i];
            string id = ids[i];
            int view = views[i];

            if (videoMap.find(creator) == videoMap.end()) {
                videoMap[creator] = {view, id};
                countMap[creator] = 1;
            } else {
                if (view > videoMap[creator].first || (view == videoMap[creator].first && id < videoMap[creator].second)) {
                    videoMap[creator] = {view, id};
                }
                countMap[creator]++;
            }
        }

        int maxCount = 0;
        for (auto& [creator, count] : countMap) {
            maxCount = max(maxCount, count);
        }

        vector<vector<string>> result;
        for (auto& [creator, data] : videoMap) {
            if (countMap[creator] == maxCount) {
                result.push_back({creator, data.second});
            }
        }

        return result;
    }
};