var findCompleteDayII = function(timeSeries, duration) {
    let count = 0;
    for (let i = 0; i < timeSeries.length - 1; i++) {
        let diff = timeSeries[i + 1] - timeSeries[i];
        count += Math.min(duration, diff);
    }
    count += duration;
    return count;
};