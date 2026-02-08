var angleClock = function(hour, minutes) {
    const minuteAngle = minutes * 6;
    const hourAngle = (hour % 12) * 30 + minutes * 0.5;
    const angle = Math.abs(hourAngle - minuteAngle);
    return Math.min(angle, 360 - angle);
};