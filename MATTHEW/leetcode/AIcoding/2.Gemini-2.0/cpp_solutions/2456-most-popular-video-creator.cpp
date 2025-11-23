#include <vector>
#include <string>
#include <unordered_map>
#include <algorithm>

using namespace std;

class Solution {
public:
    vector<vector<string>> mostPopularCreator(vector<string>& creators, vector<string>& ids, vector<int>& views) {
        unordered_map<string, long long> creator_views;
        unordered_map<string, string> creator_best_id;
        unordered_map<string, int> creator_best_id_view;

        for (int i = 0; i < creators.size(); ++i) {
            creator_views[creators[i]] += views[i];
            if (creator_best_id.find(creators[i]) == creator_best_id.end()) {
                creator_best_id[creators[i]] = ids[i];
                creator_best_id_view[creators[i]] = views[i];
            } else {
                if (views[i] > creator_best_id_view[creators[i]]) {
                    creator_best_id[creators[i]] = ids[i];
                    creator_best_id_view[creators[i]] = views[i];
                } else if (views[i] == creator_best_id_view[creators[i]]) {
                    if (ids[i] < creator_best_id[creators[i]]) {
                        creator_best_id[creators[i]] = ids[i];
                    }
                }
            }
        }

        long long max_views = 0;
        for (auto const& [key, val] : creator_views) {
            max_views = max(max_views, val);
        }

        vector<vector<string>> result;
        for (auto const& [key, val] : creator_views) {
            if (val == max_views) {
                result.push_back({key, creator_best_id[key]});
            }
        }

        return result;
    }
};