#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    double largestTriangleArea(std::vector<std::vector<int>>& points) {
        double max_area = 0.0;
        int n = points.size();

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                for (int k = j + 1; k < n; ++k) {
                    int x1 = points[i][0];
                    int y1 = points[i][1];
                    int x2 = points[j][0];
                    int y2 = points[j][1];
                    int x3 = points[k][0];
                    int y3 = points[k][1];

                    // Area formula: 0.5 * |x1(y2 - y3) + x2(y3 - y1) + x3(y1 - y2)|
                    // The expression inside std::abs is the determinant part.
                    double current_area = 0.5 * std::abs(
                        static_cast<double>(x1 * (y2 - y3) + 
                                           x2 * (y3 - y1) + 
                                           x3 * (y1 - y2))
                    );

                    max_area = std::max(max_area, current_area);
                }
            }
        }

        return max_area;
    }
};