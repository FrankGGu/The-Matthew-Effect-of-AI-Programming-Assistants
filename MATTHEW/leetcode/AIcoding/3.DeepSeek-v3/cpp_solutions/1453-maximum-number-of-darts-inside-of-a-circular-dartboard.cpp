#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numPoints(vector<vector<int>>& points, int r) {
        int n = points.size();
        int res = 1;
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double x1 = points[i][0], y1 = points[i][1];
                double x2 = points[j][0], y2 = points[j][1];
                double d = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
                if (d > 2 * r) continue;
                double x0 = (x1 + x2) / 2.0;
                double y0 = (y1 + y2) / 2.0;
                double h = sqrt(r * r - d * d / 4.0);
                double dx = (y1 - y2) / d * h;
                double dy = (x2 - x1) / d * h;
                vector<pair<double, double>> centers = {
                    {x0 + dx, y0 + dy},
                    {x0 - dx, y0 - dy}
                };
                for (auto& center : centers) {
                    int cnt = 0;
                    for (auto& p : points) {
                        double dist = sqrt((p[0] - center.first) * (p[0] - center.first) + 
                                          (p[1] - center.second) * (p[1] - center.second));
                        if (dist <= r + 1e-6) ++cnt;
                    }
                    res = max(res, cnt);
                }
            }
        }
        return res;
    }
};