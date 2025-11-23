#include <algorithm>

class Solution {
public:
    int minTimeToVisitAllPoints(std::vector<std::vector<int>>& points) {
        int time = 0;
        for (int i = 0; i < points.size() - 1; ++i) {
            int dx = std::abs(points[i+1][0] - points[i][0]);
            int dy = std::abs(points[i+1][1] - points[i][1]);
            time += std::max(dx, dy);
        }
        return time;
    }
};