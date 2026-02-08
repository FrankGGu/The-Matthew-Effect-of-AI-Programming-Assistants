#include <vector>
#include <algorithm>

class Solution {
public:
    int minRectanglesToCoverPoints(std::vector<std::vector<int>>& points, int w) {
        if (points.empty()) {
            return 0;
        }

        std::sort(points.begin(), points.end());

        int count = 1;
        int current_rect_start_x = points[0][0];

        for (const auto& point : points) {
            if (point[0] > current_rect_start_x + w) {
                count++;
                current_rect_start_x = point[0];
            }
        }

        return count;
    }
};