var nthUglyNumber = function(n) {
    if (n <= 0) {
        return 0;
    }

    const dp = new Array(n);
    dp[0] = 1;

    let p2 = 0;
    let p3 = 0;
    let p5 = 0;

    for (let i = 1; i < n; i++) {
        const next2 = dp[p2] * 2;
        const next3 = dp[p3] * 3;
        const next5 = dp[p5] * 5;

        dp[i] = Math.min(next2, next3, next5);

        if (dp[i] === next2) {
            p2++;
        }
        if (dp[i] === next3) {
            p3++;
        }
        if (dp[i] === next5) {
            p5++;
        }
    }

    return dp[n - 1];
};