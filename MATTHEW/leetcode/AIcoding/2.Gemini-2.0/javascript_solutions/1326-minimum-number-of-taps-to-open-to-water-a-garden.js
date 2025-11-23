var minTaps = function(n, ranges) {
    const intervals = [];
    for (let i = 0; i < ranges.length; i++) {
        intervals.push([i - ranges[i], i + ranges[i]]);
    }

    intervals.sort((a, b) => a[0] - b[0]);

    let count = 0;
    let reach = 0;
    let i = 0;

    while (reach < n) {
        let maxReach = reach;
        while (i < intervals.length && intervals[i][0] <= reach) {
            maxReach = Math.max(maxReach, intervals[i][1]);
            i++;
        }

        if (maxReach === reach) {
            return -1;
        }

        count++;
        reach = maxReach;
    }

    return count;
};