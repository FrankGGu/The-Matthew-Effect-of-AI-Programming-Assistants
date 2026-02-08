#include <vector>
#include <unordered_set>
#include <cmath>
#include <algorithm>
#include <cfloat>

class Solution {
public:
    double minAreaFreeRect(std::vector<std::vector<int>>& points) {
        int n = points.size();
        if (n < 4) {
            return 0.0;
        }

        std::unordered_set<long long> point_set;
        for (const auto& p : points) {
            point_set.insert(p[0] * 40001LL + p[1]);
        }

        double min_area = DBL_MAX;

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    long long x1 = points[i][0], y1 = points[i][1];
                    long long x2 = points[j][0], y2 = points[j][1];
                    long long x3 = points[k][0], y3 = points[k][1];

                    if ((x2 - x1) * (x3 - x1) + (y2 - y1) * (y3 - y1) == 0) {
                        long long x4 = x2 + x3 - x1;
                        long long y4 = y2 + y3 - y1;
                        if (point_set.count(x4 * 40001LL + y4)) {
                            long long d1_sq = (x2 - x1) * (x2 - x1) + (y2 - y1) * (y2 - y1);
                            long long d2_sq = (x3 - x1) * (x3 - x1) + (y3 - y1) * (y3 - y1);
                            double area = sqrt(static_cast<double>(d1_sq)) * sqrt(static_cast<double>(d2_sq));
                            min_area = std::min(min_area, area);
                        }
                    }

                    if ((x1 - x2) * (x3 - x2) + (y1 - y2) * (y3 - y2) == 0) {
                        long long x4 = x1 + x3 - x2;
                        long long y4 = y1 + y3 - y2;
                        if (point_set.count(x4 * 40001LL + y4)) {
                            long long d1_sq = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
                            long long d2_sq = (x3 - x2) * (x3 - x2) + (y3 - y2) * (y3 - y2);
                            double area = sqrt(static_cast<double>(d1_sq)) * sqrt(static_cast<double>(d2_sq));
                            min_area = std::min(min_area, area);
                        }
                    }

                    if ((x1 - x3) * (x2 - x3) + (y1 - y3) * (y2 - y3) == 0) {
                        long long x4 = x1 + x2 - x3;
                        long long y4 = y1 + y2 - y3;
                        if (point_set.count(x4 * 40001LL + y4)) {
                            long long d1_sq = (x1 - x3) * (x1 - x3) + (y1 - y3) * (y1 - y3);
                            long long d2_sq = (x2 - x3) * (x2 - x3) + (y2 - y3) * (y2 - y3);
                            double area = sqrt(static_cast<double>(d1_sq)) * sqrt(static_cast<double>(d2_sq));
                            min_area = std::min(min_area, area);
                        }
                    }
                }
            }
        }

        return min_area == DBL_MAX ? 0.0 : min_area;
    }
};