#include <vector>
#include <cmath>
#include <algorithm>

class Solution {
public:
    int visiblePoints(std::vector<std::vector<int>>& points, int angle, std::vector<int>& location) {
        int same_points = 0;
        std::vector<double> angles;
        long double PI = acos(-1.0L);

        for (const auto& p : points) {
            if (p[0] == location[0] && p[1] == location[1]) {
                same_points++;
                continue;
            }
            angles.push_back(atan2(p[1] - location[1], p[0] - location[0]) * 180.0 / PI);
        }

        std::sort(angles.begin(), angles.end());

        int n = angles.size();
        for (int i = 0; i < n; ++i) {
            angles.push_back(angles[i] + 360.0);
        }

        int max_visible = 0;
        int left = 0;
        for (int right = 0; right < angles.size(); ++right) {
            while (angles[right] - angles[left] > angle) {
                left++;
            }
            max_visible = std::max(max_visible, right - left + 1);
        }

        return max_visible + same_points;
    }
};