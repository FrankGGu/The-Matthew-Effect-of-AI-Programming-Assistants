var minTaps = function(n, ranges) {
    const intervals = [];
    for (let i = 0; i <= n; i++) {
        const start = Math.max(0, i - ranges[i]);
        const end = Math.min(n, i + ranges[i]);
        intervals.push([start, end]);
    }
    intervals.sort((a, b) => a[0] - b[0]);

    let res = 0;
    let currentEnd = 0;
    let i = 0;
    while (currentEnd < n) {
        let maxEnd = currentEnd;
        while (i <= n && intervals[i][0] <= currentEnd) {
            maxEnd = Math.max(maxEnd, intervals[i][1]);
            i++;
        }
        if (maxEnd === currentEnd) {
            return -1;
        }
        currentEnd = maxEnd;
        res++;
    }
    return res;
};