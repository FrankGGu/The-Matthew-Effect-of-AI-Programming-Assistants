function findMinDifference(timePoints) {
    const minutes = timePoints.map(time => {
        const [h, m] = time.split(':').map(Number);
        return h * 60 + m;
    }).sort((a, b) => a - b);

    let minDiff = Infinity;
    for (let i = 1; i < minutes.length; i++) {
        minDiff = Math.min(minDiff, minutes[i] - minutes[i - 1]);
    }

    const wrapAroundDiff = (1440 - minutes[minutes.length - 1]) + minutes[0];
    minDiff = Math.min(minDiff, wrapAroundDiff);

    return minDiff;
}