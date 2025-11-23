var merge = function(intervals) {
    if (intervals.length === 0) {
        return [];
    }

    intervals.sort((a, b) => a[0] - b[0]);

    const merged = [];
    for (let i = 0; i < intervals.length; i++) {
        const currentInterval = intervals[i];
        if (merged.length === 0 || currentInterval[0] > merged[merged.length - 1][1]) {
            merged.push(currentInterval);
        } else {
            merged[merged.length - 1][1] = Math.max(merged[merged.length - 1][1], currentInterval[1]);
        }
    }

    return merged;
};