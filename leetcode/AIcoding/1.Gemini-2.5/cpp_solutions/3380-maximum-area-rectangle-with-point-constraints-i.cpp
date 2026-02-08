#include <vector>
#include <algorithm>
#include <limits>

class Solution {
public:
    long long maxArea(std::vector<std::vector<int>>& points) {
        if (points.empty()) {
            return 0;
        }

        long long min_x = std::numeric_limits<long long>::max();
        long long max_x = std::numeric_limits<long long>::min();
        long long min_y = std::numeric_limits<long long>::max();
        long long max_y = std::numeric_limits<long long>::min();

        for (const auto& p : points) {
            min_x = std::min(min_x, (long long)p[0]);
            max_x = std::max(max_x, (long long)p[0]);
            min_y = std::min(min_y, (long long)p[1]);
            max_y = std::max(max_y, (long long)p[1]);
        }

        long long width = max_x - min_x;
        long long height = max_y - min_y;

        return width * height;
    }
};