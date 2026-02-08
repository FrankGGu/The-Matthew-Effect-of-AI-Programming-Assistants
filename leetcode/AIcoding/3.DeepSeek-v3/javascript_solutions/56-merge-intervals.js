var merge = function(intervals) {
    if (intervals.length === 0) return [];
    intervals.sort((a, b) => a[0] - b[0]);
    let merged = [intervals[0]];
    for (let i = 1; i < intervals.length; i++) {
        let last = merged[merged.length - 1];
        let current = intervals[i];
        if (current[0] <= last[1]) {
            last[1] = Math.max(last[1], current[1]);
        } else {
            merged.push(current);
        }
    }
    return merged;
};