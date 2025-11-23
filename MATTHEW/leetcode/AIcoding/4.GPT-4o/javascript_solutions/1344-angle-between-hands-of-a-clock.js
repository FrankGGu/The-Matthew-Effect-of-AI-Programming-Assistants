var angleClock = function(hour, minutes) {
    const hourAngle = (hour % 12 + minutes / 60) * 30;
    const minuteAngle = minutes * 6;
    const angle = Math.abs(hourAngle - minuteAngle);
    return Math.min(angle, 360 - angle);
};