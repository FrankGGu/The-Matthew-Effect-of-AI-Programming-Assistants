#include <vector>
#include <cmath>
#include <algorithm>

using namespace std;

class Solution {
public:
    int numPoints(vector<vector<int>>& points, int r) {
        int n = points.size();
        int max_points = 1;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double x1 = points[i][0], y1 = points[i][1];
                double x2 = points[j][0], y2 = points[j][1];
                double dist = sqrt(pow(x1 - x2, 2) + pow(y1 - y2, 2));

                if (dist > 2 * r) continue;

                double mid_x = (x1 + x2) / 2.0;
                double mid_y = (y1 + y2) / 2.0;
                double d = sqrt(pow(r, 2) - pow(dist / 2.0, 2));

                double angle = atan2(y2 - y1, x2 - x1);
                double dx = d * sin(angle);
                double dy = d * cos(angle);

                double center_x1 = mid_x + dx;
                double center_y1 = mid_y - dy;
                double center_x2 = mid_x - dx;
                double center_y2 = mid_y + dy;

                int count1 = 0;
                for (int k = 0; k < n; ++k) {
                    double px = points[k][0], py = points[k][1];
                    double dist_to_center = sqrt(pow(px - center_x1, 2) + pow(py - center_y1, 2));
                    if (dist_to_center <= r + 1e-9) {
                        count1++;
                    }
                }

                int count2 = 0;
                for (int k = 0; k < n; ++k) {
                    double px = points[k][0], py = points[k][1];
                    double dist_to_center = sqrt(pow(px - center_x2, 2) + pow(py - center_y2, 2));
                    if (dist_to_center <= r + 1e-9) {
                        count2++;
                    }
                }

                max_points = max(max_points, max(count1, count2));
            }
        }

        return max_points;
    }
};