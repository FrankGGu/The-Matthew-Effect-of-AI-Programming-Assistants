#include <vector>
#include <algorithm>

class Solution {
public:
    int maxWidthOfVerticalArea(std::vector<std::vector<int>>& points) {
        std::sort(points.begin(), points.end());

        int maxWidth = 0;
        for (size_t i = 1; i < points.size(); ++i) {
            maxWidth = std::max(maxWidth, points[i][0] - points[i - 1][0]);
        }

        return maxWidth;
    }
};