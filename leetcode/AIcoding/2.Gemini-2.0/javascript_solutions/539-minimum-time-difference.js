var findMinDifference = function(timePoints) {
    const minutes = timePoints.map(time => {
        const [hours, mins] = time.split(':').map(Number);
        return hours * 60 + mins;
    }).sort((a, b) => a - b);

    let minDiff = Infinity;
    for (let i = 1; i < minutes.length; i++) {
        minDiff = Math.min(minDiff, minutes[i] - minutes[i - 1]);
    }

    minDiff = Math.min(minDiff, minutes[0] + 1440 - minutes[minutes.length - 1]);

    return minDiff;
};