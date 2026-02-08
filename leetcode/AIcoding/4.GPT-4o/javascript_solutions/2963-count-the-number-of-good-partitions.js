var countGoodPartitions = function(s) {
    const MOD = 1e9 + 7;
    const n = s.length;
    const dp = new Array(n + 1).fill(0);
    dp[0] = 1;
    const prefix = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        prefix[i] = prefix[i - 1] + (s[i - 1] === '1' ? 1 : -1);
    }

    const countMap = new Map();
    for (let i = 0; i <= n; i++) {
        const key = prefix[i];
        dp[i] = countMap.get(key) || 0;
        countMap.set(key, (countMap.get(key) || 0) + dp[i]);
        dp[i] = (dp[i] + 1) % MOD;
    }

    return dp[n];
};