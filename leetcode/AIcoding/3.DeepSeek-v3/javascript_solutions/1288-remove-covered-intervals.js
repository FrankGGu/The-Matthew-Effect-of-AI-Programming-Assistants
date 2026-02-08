var removeCoveredIntervals = function(intervals) {
    intervals.sort((a, b) => {
        if (a[0] === b[0]) {
            return b[1] - a[1];
        }
        return a[0] - b[0];
    });

    let count = 0;
    let prev_end = 0;

    for (const interval of intervals) {
        if (interval[1] > prev_end) {
            count++;
            prev_end = interval[1];
        }
    }

    return count;
};