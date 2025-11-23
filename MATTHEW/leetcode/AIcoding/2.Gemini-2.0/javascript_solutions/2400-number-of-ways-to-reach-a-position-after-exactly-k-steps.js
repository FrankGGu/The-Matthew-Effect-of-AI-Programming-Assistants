var numberOfWays = function(startPos, endPos, k) {
    const MOD = 10**9 + 7;
    const diff = Math.abs(endPos - startPos);

    if (diff > k || (k - diff) % 2 !== 0) {
        return 0;
    }

    const dp = Array(k + 1).fill(null).map(() => Array(k + 1).fill(0));
    dp[0][0] = 1;

    for (let i = 1; i <= k; i++) {
        for (let j = 0; j <= i; j++) {
            if (j > 0) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j - 1]) % MOD;
            }
            if (j < i) {
                dp[i][j] = (dp[i][j] + dp[i - 1][j]) % MOD;
            }
        }
    }

    const stepsRight = (k + diff) / 2;
    const stepsLeft = k - stepsRight;

    const combinations = (n, r) => {
        if (r < 0 || r > n) {
            return 0;
        }
        if (r === 0 || r === n) {
            return 1;
        }
        if (r > n / 2) {
            r = n - r;
        }

        let result = 1;
        for (let i = 1; i <= r; i++) {
            result = (result * (n - i + 1)) / i;
        }
        return result;
    };

    return combinations(k, stepsRight) % MOD;
};