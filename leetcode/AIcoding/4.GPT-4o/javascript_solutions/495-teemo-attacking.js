var findPoisonedDuration = function(timeSeries, duration) {
    let totalPoisonedTime = 0;
    for (let i = 1; i < timeSeries.length; i++) {
        totalPoisonedTime += Math.min(duration, timeSeries[i] - timeSeries[i - 1]);
    }
    return totalPoisonedTime + duration;
};