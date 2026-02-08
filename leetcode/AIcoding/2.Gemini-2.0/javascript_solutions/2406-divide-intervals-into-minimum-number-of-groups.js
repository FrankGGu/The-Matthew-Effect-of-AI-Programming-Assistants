var minGroups = function(intervals) {
    intervals.sort((a, b) => a[0] - b[0]);
    const pq = [];

    for (const interval of intervals) {
        if (pq.length > 0 && pq[0] <= interval[0]) {
            pq.shift();
        }
        pq.push(interval[1]);
        pq.sort((a,b) => a-b);
    }

    return pq.length;
};