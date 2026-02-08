class Solution {
public:
    vector<vector<string>> mostPopularCreator(vector<string>& creators, vector<string>& ids, vector<int>& views) {
        unordered_map<string, long long> popularity;
        unordered_map<string, pair<string, int>> topVideo;
        long long maxPopularity = 0;

        for (int i = 0; i < creators.size(); ++i) {
            string creator = creators[i];
            string id = ids[i];
            int view = views[i];

            popularity[creator] += view;
            maxPopularity = max(maxPopularity, popularity[creator]);

            if (topVideo.find(creator) == topVideo.end()) {
                topVideo[creator] = {id, view};
            } else {
                auto& current = topVideo[creator];
                if (view > current.second || (view == current.second && id < current.first)) {
                    current = {id, view};
                }
            }
        }

        vector<vector<string>> result;
        for (auto& [creator, totalViews] : popularity) {
            if (totalViews == maxPopularity) {
                result.push_back({creator, topVideo[creator].first});
            }
        }

        return result;
    }
};