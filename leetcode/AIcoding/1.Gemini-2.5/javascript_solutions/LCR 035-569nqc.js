var findMinDifference = function(timePoints) {
    const minutes = [];
    for (let i = 0; i < timePoints.length; i++) {
        const time = timePoints[i];
        const [hourStr, minuteStr] = time.split(':');
        const hour = parseInt(hourStr);
        const minute = parseInt(minuteStr);
        minutes.push(hour * 60 + minute);
    }

    minutes.sort((a, b) => a - b);

    let minDiff = Infinity;
    for (let i = 0; i < minutes.length - 1; i++) {
        minDiff = Math.min(minDiff, minutes[i + 1] - minutes[i]);
    }

    const wrapAroundDiff = (24 * 60) - minutes[minutes.length - 1] + minutes[0];
    minDiff = Math.min(minDiff, wrapAroundDiff);

    return minDiff;
};