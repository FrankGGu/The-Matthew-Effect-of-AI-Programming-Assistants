#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double angleClock(int hour, int minutes) {
    double hour_angle = (hour % 12 + (double)minutes / 60) * 30;
    double minute_angle = minutes * 6;
    double angle = fabs(hour_angle - minute_angle);
    return fmin(angle, 360 - angle);
}