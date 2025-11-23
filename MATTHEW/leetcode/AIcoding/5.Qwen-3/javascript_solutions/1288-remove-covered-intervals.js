function removeCoveredIntervals(intervals) {
    intervals.sort((a, b) => a[0] - b[0] || b[1] - a[1]);
    let result = [];
    for (let interval of intervals) {
        if (result.length === 0 || interval[1] > result[result.length - 1][1]) {
            result.push(interval);
        }
    }
    return result;
}