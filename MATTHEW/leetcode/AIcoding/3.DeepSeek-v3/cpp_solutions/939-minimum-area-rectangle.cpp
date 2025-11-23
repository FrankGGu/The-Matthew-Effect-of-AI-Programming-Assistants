class Solution {
public:
    int minAreaRect(vector<vector<int>>& points) {
        unordered_map<int, unordered_set<int>> pointSet;
        for (auto& p : points) {
            pointSet[p[0]].insert(p[1]);
        }

        int minArea = INT_MAX;
        int n = points.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                int x1 = points[i][0], y1 = points[i][1];
                int x2 = points[j][0], y2 = points[j][1];

                if (x1 != x2 && y1 != y2) {
                    if (pointSet[x1].count(y2) && pointSet[x2].count(y1)) {
                        int area = abs(x1 - x2) * abs(y1 - y2);
                        if (area < minArea) {
                            minArea = area;
                        }
                    }
                }
            }
        }

        return minArea == INT_MAX ? 0 : minArea;
    }
};