function changingKeys(keys, target) {
    const n = keys.length;
    const dp = Array(n + 1).fill(0);
    dp[0] = 1;

    for (let i = 1; i <= n; i++) {
        for (let j = target; j >= keys[i - 1]; j--) {
            dp[j] += dp[j - keys[i - 1]];
        }
    }

    return dp[target];
}