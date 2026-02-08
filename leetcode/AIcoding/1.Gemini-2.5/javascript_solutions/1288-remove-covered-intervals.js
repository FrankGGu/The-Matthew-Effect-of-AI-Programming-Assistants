var removeCoveredIntervals = function(intervals) {
    intervals.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        }
        return b[1] - a[1];
    });

    let nonCoveredCount = 0;
    let currentMaxEnd = -1;

    for (let i = 0; i < intervals.length; i++) {
        const [start, end] = intervals[i];

        if (end > currentMaxEnd) {
            nonCoveredCount++;
            currentMaxEnd = end;
        }
    }

    return nonCoveredCount;
};