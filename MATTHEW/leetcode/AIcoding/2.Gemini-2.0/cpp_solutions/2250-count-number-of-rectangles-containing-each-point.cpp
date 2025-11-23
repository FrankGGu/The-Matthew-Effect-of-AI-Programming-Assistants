class Solution {
public:
    vector<int> countRectangles(vector<vector<int>>& rectangles, vector<vector<int>>& points) {
        vector<vector<int>> heights(101);
        for (auto& rect : rectangles) {
            heights[rect[1]].push_back(rect[0]);
        }
        for (int i = 1; i <= 100; ++i) {
            sort(heights[i].begin(), heights[i].end());
        }
        vector<int> ans(points.size());
        for (int i = 0; i < points.size(); ++i) {
            int count = 0;
            for (int j = points[i][1]; j <= 100; ++j) {
                count += heights[j].end() - lower_bound(heights[j].begin(), heights[j].end(), points[i][0]);
            }
            ans[i] = count;
        }
        return ans;
    }
};