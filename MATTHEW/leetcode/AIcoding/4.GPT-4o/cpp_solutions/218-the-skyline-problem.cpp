class Solution {
public:
    vector<vector<int>> getSkyline(vector<vector<int>>& buildings) {
        vector<vector<int>> result;
        vector<pair<int, int>> heights;

        for (auto& b : buildings) {
            heights.emplace_back(b[0], -b[2]);
            heights.emplace_back(b[1], b[2]);
        }

        sort(heights.begin(), heights.end());

        multiset<int> liveHeights;
        liveHeights.insert(0);
        int prevMaxHeight = 0;

        for (auto& h : heights) {
            if (h.second < 0) {
                liveHeights.insert(-h.second);
            } else {
                liveHeights.erase(liveHeights.find(h.second));
            }

            int currentMaxHeight = *liveHeights.rbegin();
            if (currentMaxHeight != prevMaxHeight) {
                result.push_back({h.first, currentMaxHeight});
                prevMaxHeight = currentMaxHeight;
            }
        }

        return result;
    }
};