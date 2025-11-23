double angleClock(int hour, int minutes) {
    double hour_angle = (hour % 12) * 30.0 + minutes * 0.5;
    double minute_angle = minutes * 6.0;
    double diff = fabs(hour_angle - minute_angle);
    return fmin(diff, 360.0 - diff);
}