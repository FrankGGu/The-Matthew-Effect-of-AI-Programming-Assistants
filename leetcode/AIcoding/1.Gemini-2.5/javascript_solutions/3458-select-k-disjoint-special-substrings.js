var selectKDisjointSpecialSubstrings = function(s, k) {
    const n = s.length;
    const MOD = 10**9 + 7;

    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    for (let i = 0; i <= n; i++) {
        dp[i][0] = 1;
    }

    const balance = Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        balance[i + 1] = balance[i];
        if (s[i] === '1') {
            balance[i + 1]++;
        } else if (s[i] === '0') {
            balance[i + 1]--;
        }
    }

    for (let j = 1; j <= k; j++) {
        const sumMap = new Map();
        sumMap.set(balance[0], dp[0][j - 1]);

        for (let i = 1; i <= n; i++) {
            dp[i][j] = dp[i - 1][j];

            if (sumMap.has(balance[i])) {
                dp[i][j] = (dp[i][j] + sumMap.get(balance[i])) % MOD;
            }

            sumMap.set(balance[i], (sumMap.get(balance[i]) || 0) + dp[i][j - 1]);
            sumMap.set(balance[i], sumMap.get(balance[i]) % MOD);
        }
    }

    return dp[n][k];
};