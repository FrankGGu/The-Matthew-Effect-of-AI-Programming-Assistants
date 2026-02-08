#include <cmath>
#include <algorithm>

class Solution {
public:
    bool isReachableAtTime(int sx, int sy, int fx, int fy, int t) {
        int dx = std::abs(sx - fx);
        int dy = std::abs(sy - fy);

        int min_time = std::max(dx, dy);

        if (min_time == 0) {
            return t == 0;
        } else {
            return t >= min_time;
        }
    }
};