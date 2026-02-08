var findMinDifference = function(timePoints) {
    if (timePoints.length > 1440) {
        return 0;
    }

    const minutes = [];
    for (const timePoint of timePoints) {
        const [hourStr, minuteStr] = timePoint.split(':');
        const hour = parseInt(hourStr);
        const minute = parseInt(minuteStr);
        minutes.push(hour * 60 + minute);
    }

    minutes.sort((a, b) => a - b);

    let minDiff = Infinity;
    const n = minutes.length;

    for (let i = 0; i < n - 1; i++) {
        minDiff = Math.min(minDiff, minutes[i+1] - minutes[i]);
    }

    minDiff = Math.min(minDiff, (24 * 60 - minutes[n-1]) + minutes[0]);

    return minDiff;
};