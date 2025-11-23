var findPoisonedDuration = function(timeSeries, duration) {
    if (timeSeries.length === 0) return 0;
    let totalDuration = 0;
    for (let i = 0; i < timeSeries.length - 1; i++) {
        totalDuration += Math.min(duration, timeSeries[i + 1] - timeSeries[i]);
    }
    totalDuration += duration;
    return totalDuration;
};