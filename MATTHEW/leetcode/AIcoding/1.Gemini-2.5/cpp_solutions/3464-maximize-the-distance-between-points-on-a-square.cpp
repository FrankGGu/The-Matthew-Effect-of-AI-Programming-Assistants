#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    double maxDistance(std::vector<std::vector<int>>& points) {
        double max_dist_sq = 0.0;
        int n = points.size();

        if (n < 2) {
            return 0.0;
        }

        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                long long dx = static_cast<long long>(points[i][0]) - points[j][0];
                long long dy = static_cast<long long>(points[i][1]) - points[j][1];

                double current_dist_sq = static_cast<double>(dx * dx + dy * dy);

                max_dist_sq = std::max(max_dist_sq, current_dist_sq);
            }
        }

        return std::sqrt(max_dist_sq);
    }
};