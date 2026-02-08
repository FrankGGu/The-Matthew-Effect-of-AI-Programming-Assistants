var findSumOfArrayProductOfMagicalSequences = function(n, k) {
    const MOD = 10**9 + 7;

    let dp = new Array(k + 1).fill(0);

    for (let j = 1; j <= k; j++) {
        dp[j] = j;
    }

    for (let i = 2; i <= n; i++) {
        let next_dp = new Array(k + 1).fill(0);
        for (let p = 1; p <= k; p++) {
            if (dp[p] === 0) {
                continue;
            }
            for (let j = p; j <= k; j += p) {
                next_dp[j] = (next_dp[j] + dp[p] * j) % MOD;
            }
        }
        dp = next_dp;
    }

    let totalSum = 0;
    for (let j = 1; j <= k; j++) {
        totalSum = (totalSum + dp[j]) % MOD;
    }

    return totalSum;
};