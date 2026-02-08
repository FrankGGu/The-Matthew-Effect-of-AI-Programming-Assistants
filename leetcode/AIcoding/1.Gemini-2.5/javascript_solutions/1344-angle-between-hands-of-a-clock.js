var angleClock = function(hour, minutes) {
    let minuteAngle = minutes * 6;
    let hourAngle = (hour % 12) * 30 + (minutes / 60) * 30;

    let diff = Math.abs(hourAngle - minuteAngle);

    return Math.min(diff, 360 - diff);
};