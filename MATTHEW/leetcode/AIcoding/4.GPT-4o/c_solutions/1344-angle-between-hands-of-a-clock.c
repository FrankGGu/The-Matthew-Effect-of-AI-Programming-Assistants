double angleClock(int hour, int minutes) {
    if (hour == 12) hour = 0;
    if (minutes == 60) {
        minutes = 0;
        hour++;
    }
    double hour_angle = 30 * hour + 0.5 * minutes;
    double minute_angle = 6 * minutes;
    double angle = fabs(hour_angle - minute_angle);
    return fmin(angle, 360 - angle);
}