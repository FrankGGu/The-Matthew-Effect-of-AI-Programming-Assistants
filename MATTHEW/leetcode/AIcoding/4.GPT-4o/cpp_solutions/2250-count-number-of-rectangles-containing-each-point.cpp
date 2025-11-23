class Solution {
public:
    vector<int> countRectangles(vector<vector<int>>& rectangles, vector<vector<int>>& points) {
        vector<int> result(points.size(), 0);
        vector<pair<int, int>> rects;

        for (const auto& rect : rectangles) {
            rects.emplace_back(rect[0], rect[1]);
        }

        sort(rects.begin(), rects.end());

        for (int i = 0; i < points.size(); ++i) {
            int x = points[i][0], y = points[i][1];
            for (const auto& rect : rects) {
                if (rect.first >= x) break;
                if (rect.second >= y) ++result[i];
            }
        }

        return result;
    }
};