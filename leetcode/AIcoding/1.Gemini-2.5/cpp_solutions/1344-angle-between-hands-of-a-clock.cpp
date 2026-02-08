#include <cmath>

class Solution {
public:
    double angleClock(int hour, int minutes) {
        double hour_angle = (hour % 12 + minutes / 60.0) * 30;
        double minute_angle = minutes * 6;
        double diff = abs(hour_angle - minute_angle);
        return min(diff, 360 - diff);
    }
};