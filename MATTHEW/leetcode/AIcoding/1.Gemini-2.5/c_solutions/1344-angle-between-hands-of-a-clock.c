#include <math.h>

double angleClock(int hour, int minute) {
    double minute_angle = minute * 6.0;
    double hour_angle = (hour % 12 + minute / 60.0) * 30.0;
    double diff = fabs(hour_angle - minute_angle);
    return fmin(diff, 360.0 - diff);
}