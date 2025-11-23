var nthUglyNumber = function(n) {
    const dp = new Array(n);
    dp[0] = 1;
    let i2 = 0, i3 = 0, i5 = 0;
    let next2 = 2, next3 = 3, next5 = 5;

    for (let i = 1; i < n; i++) {
        const nextUgly = Math.min(next2, next3, next5);
        dp[i] = nextUgly;

        if (nextUgly === next2) {
            i2++;
            next2 = dp[i2] * 2;
        }
        if (nextUgly === next3) {
            i3++;
            next3 = dp[i3] * 3;
        }
        if (nextUgly === next5) {
            i5++;
            next5 = dp[i5] * 5;
        }
    }

    return dp[n - 1];
};