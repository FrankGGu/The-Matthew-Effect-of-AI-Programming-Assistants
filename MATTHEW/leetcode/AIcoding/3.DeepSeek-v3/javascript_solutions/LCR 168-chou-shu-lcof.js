var nthUglyNumber = function(n) {
    let ugly = [1];
    let i2 = 0, i3 = 0, i5 = 0;
    for (let i = 1; i < n; i++) {
        let next2 = ugly[i2] * 2;
        let next3 = ugly[i3] * 3;
        let next5 = ugly[i5] * 5;
        let next = Math.min(next2, next3, next5);
        ugly.push(next);
        if (next === next2) i2++;
        if (next === next3) i3++;
        if (next === next5) i5++;
    }
    return ugly[n - 1];
};