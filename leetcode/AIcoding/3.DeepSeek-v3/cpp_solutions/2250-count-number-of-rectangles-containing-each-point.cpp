class Solution {
public:
    vector<int> countRectangles(vector<vector<int>>& rectangles, vector<vector<int>>& points) {
        vector<vector<int>> heights(101);
        for (auto& rect : rectangles) {
            int l = rect[0], h = rect[1];
            heights[h].push_back(l);
        }
        for (auto& h : heights) {
            sort(h.begin(), h.end());
        }
        vector<int> res;
        for (auto& point : points) {
            int x = point[0], y = point[1];
            int cnt = 0;
            for (int h = y; h <= 100; ++h) {
                auto& ls = heights[h];
                auto it = lower_bound(ls.begin(), ls.end(), x);
                cnt += ls.end() - it;
            }
            res.push_back(cnt);
        }
        return res;
    }
};