var removeCoveredIntervals = function(intervals) {
    intervals.sort((a, b) => {
        if (a[0] === b[0]) {
            return b[1] - a[1];
        }
        return a[0] - b[0];
    });

    let count = 0;
    let right = 0;

    for (let interval of intervals) {
        if (interval[1] > right) {
            count++;
            right = interval[1];
        }
    }

    return count;
};