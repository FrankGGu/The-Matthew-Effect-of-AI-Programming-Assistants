var intersectionSizeTwo = function(intervals) {
    intervals.sort((a, b) => a[1] - b[1] || b[0] - a[0]);
    let res = 0;
    let first = -1, second = -1;

    for (const [start, end] of intervals) {
        if (start > second) {
            res += 2;
            first = end - 1;
            second = end;
        } else if (start > first) {
            res += 1;
            first = second;
            second = end;
        }
    }

    return res;
};