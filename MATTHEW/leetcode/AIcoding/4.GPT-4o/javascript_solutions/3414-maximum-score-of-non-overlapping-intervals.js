var maxNonOverlapping = function(intervals) {
    intervals.sort((a, b) => a[1] - b[1]);
    let totalScore = 0, lastEnd = -Infinity;

    for (const [start, end] of intervals) {
        if (start >= lastEnd) {
            totalScore++;
            lastEnd = end;
        }
    }

    return totalScore;
};