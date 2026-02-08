class Solution {
public:
    int maxAreaRectWithPoint(vector<vector<int>>& points, int x, int y) {
        set<pair<int, int>> pointSet;
        for (auto& p : points) {
            pointSet.insert({p[0], p[1]});
        }

        int maxArea = 0;
        int n = points.size();

        for (int i = 0; i < n; ++i) {
            int x1 = points[i][0], y1 = points[i][1];
            for (int j = 0; j < n; ++j) {
                int x2 = points[j][0], y2 = points[j][1];
                if (x1 < x2 && y1 < y2) {
                    if (pointSet.count({x1, y2}) && pointSet.count({x2, y1})) {
                        if (x1 <= x && x <= x2 && y1 <= y && y <= y2) {
                            int area = (x2 - x1) * (y2 - y1);
                            if (area > maxArea) {
                                maxArea = area;
                            }
                        }
                    }
                }
            }
        }

        return maxArea;
    }
};