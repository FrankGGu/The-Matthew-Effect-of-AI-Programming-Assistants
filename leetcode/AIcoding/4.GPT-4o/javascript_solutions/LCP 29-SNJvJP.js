function numWays(people) {
    const mod = 1e9 + 7;
    const dp = new Array(people + 1).fill(0);
    dp[0] = 1;

    for (let i = 2; i <= people; i += 2) {
        for (let j = i; j >= 2; j -= 2) {
            dp[j] = (dp[j] + dp[j - 2] * (j - 1)) % mod;
        }
    }

    return dp[people];
}