var nthUglyNumber = function(n) {
    const ugly = new Array(n);
    ugly[0] = 1;
    let i2 = 0, i3 = 0, i5 = 0;
    for (let i = 1; i < n; i++) {
        const next2 = ugly[i2] * 2;
        const next3 = ugly[i3] * 3;
        const next5 = ugly[i5] * 5;
        ugly[i] = Math.min(next2, next3, next5);
        if (ugly[i] === next2) i2++;
        if (ugly[i] === next3) i3++;
        if (ugly[i] === next5) i5++;
    }
    return ugly[n - 1];
};