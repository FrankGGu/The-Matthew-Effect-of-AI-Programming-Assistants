var angleClock = function(hour, minutes) {
    let hourAngle = (hour % 12 + minutes / 60) * 30;
    let minuteAngle = minutes * 6;
    let angle = Math.abs(hourAngle - minuteAngle);
    return Math.min(angle, 360 - angle);
};