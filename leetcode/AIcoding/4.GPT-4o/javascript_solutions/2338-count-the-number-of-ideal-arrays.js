var idealArrays = function(n, maxValue) {
    const MOD = 1e9 + 7;
    const dp = new Array(maxValue + 1).fill(0);
    const prefix = new Array(maxValue + 1).fill(0);

    for (let i = 1; i <= maxValue; i++) {
        dp[i] = 1;
        for (let j = 2 * i; j <= maxValue; j += i) {
            dp[j] = (dp[j] + dp[i]) % MOD;
        }
    }

    let result = 0;

    for (let i = 1; i <= maxValue; i++) {
        let count = dp[i];
        let total = 1;
        for (let j = 0; j < n - 1; j++) {
            total = (total * count) % MOD;
        }
        result = (result + total) % MOD;
    }

    return result;
};