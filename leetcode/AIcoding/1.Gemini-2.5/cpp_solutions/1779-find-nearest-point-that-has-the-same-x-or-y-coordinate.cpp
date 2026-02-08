#include <vector>
#include <cmath>
#include <limits>

class Solution {
public:
    int nearestValidPoint(int x, int y, std::vector<std::vector<int>>& points) {
        int min_dist = std::numeric_limits<int>::max();
        int min_idx = -1;

        for (int i = 0; i < points.size(); ++i) {
            int px = points[i][0];
            int py = points[i][1];

            if (px == x || py == y) {
                int dist = std::abs(x - px) + std::abs(y - py);
                if (dist < min_dist) {
                    min_dist = dist;
                    min_idx = i;
                }
            }
        }

        return min_idx;
    }
};