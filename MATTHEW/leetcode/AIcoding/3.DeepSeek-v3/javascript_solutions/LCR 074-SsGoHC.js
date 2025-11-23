var merge = function(intervals) {
    if (intervals.length === 0) return [];
    intervals.sort((a, b) => a[0] - b[0]);
    let res = [intervals[0]];
    for (let i = 1; i < intervals.length; i++) {
        let last = res[res.length - 1];
        if (intervals[i][0] <= last[1]) {
            last[1] = Math.max(last[1], intervals[i][1]);
        } else {
            res.push(intervals[i]);
        }
    }
    return res;
};