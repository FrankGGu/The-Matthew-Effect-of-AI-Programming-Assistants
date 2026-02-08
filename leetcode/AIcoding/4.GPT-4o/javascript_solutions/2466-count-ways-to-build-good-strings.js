var countGoodStrings = function(low, high, zero, one) {
    const MOD = 1e9 + 7;
    const dp = new Array(high + 1).fill(0);
    dp[0] = 1;

    for (let i = 0; i <= high; i++) {
        if (i + zero <= high) dp[i + zero] = (dp[i + zero] + dp[i]) % MOD;
        if (i + one <= high) dp[i + one] = (dp[i + one] + dp[i]) % MOD;
    }

    let result = 0;
    for (let i = low; i <= high; i++) {
        result = (result + dp[i]) % MOD;
    }

    return result;
};