var findIntegers = function(n) {
    const dp = new Array(32).fill(0);
    dp[0] = 1;
    dp[1] = 2;
    for (let i = 2; i < 32; i++) {
        dp[i] = dp[i - 1] + dp[i - 2];
    }
    let res = 0;
    let prevBit = 0;
    for (let i = 30; i >= 0; i--) {
        if ((n & (1 << i)) !== 0) {
            res += dp[i];
            if (prevBit === 1) {
                return res;
            }
            prevBit = 1;
        } else {
            prevBit = 0;
        }
    }
    return res + 1;
};