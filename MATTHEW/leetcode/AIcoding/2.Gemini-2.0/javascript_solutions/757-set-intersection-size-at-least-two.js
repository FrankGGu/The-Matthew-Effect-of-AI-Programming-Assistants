var intersectionSizeTwo = function(intervals) {
    intervals.sort((a, b) => a[1] === b[1] ? b[0] - a[0] : a[1] - b[1]);
    let result = 0;
    let a = -1;
    let b = -1;

    for (let interval of intervals) {
        let start = interval[0];
        let end = interval[1];

        if (a >= start && b >= start) {
            continue;
        } else if (b >= start) {
            a = b;
            b = end;
            result++;
        } else {
            a = end - 1;
            b = end;
            result += 2;
        }
    }

    return result;
};