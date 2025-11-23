var findCompleteDays = function(timeSeries, duration) {
    let count = 0;
    let end = -1;
    for (let i = 0; i < timeSeries.length; i++) {
        if (timeSeries[i] > end) {
            count += duration;
        } else {
            count += timeSeries[i] + duration - end - 1;
        }
        end = timeSeries[i] + duration - 1;
    }
    return count;
};