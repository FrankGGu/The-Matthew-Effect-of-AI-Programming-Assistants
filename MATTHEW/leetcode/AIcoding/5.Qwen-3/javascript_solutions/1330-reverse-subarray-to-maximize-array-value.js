function maxValueAfterReverse(a) {
    let n = a.length;
    if (n === 1) return 0;

    let maxDiff = 0;
    let minDiff = 0;

    for (let i = 0; i < n - 1; i++) {
        let diff = Math.abs(a[i] - a[i + 1]);
        maxDiff = Math.max(maxDiff, diff);
        minDiff = Math.min(minDiff, diff);
    }

    let res = maxDiff - minDiff;

    let max1 = 0, min1 = Infinity;
    let max2 = 0, min2 = Infinity;

    for (let i = 0; i < n - 1; i++) {
        let val1 = Math.abs(a[i] - a[i + 1]);
        let val2 = Math.abs(a[i] - a[0]) + Math.abs(a[n - 1] - a[i + 1]);
        max1 = Math.max(max1, val2);
        min1 = Math.min(min1, val2);

        let val3 = Math.abs(a[i] - a[i + 1]);
        let val4 = Math.abs(a[i] - a[n - 1]) + Math.abs(a[0] - a[i + 1]);
        max2 = Math.max(max2, val4);
        min2 = Math.min(min2, val4);
    }

    res = Math.max(res, max1 - min1, max2 - min2);

    return res;
}