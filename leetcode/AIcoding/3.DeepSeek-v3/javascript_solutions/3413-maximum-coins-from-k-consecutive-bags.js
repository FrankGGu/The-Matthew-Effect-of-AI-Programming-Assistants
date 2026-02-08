var maxCoins = function(bags, k) {
    bags.sort((a, b) => a - b);
    const n = bags.length;
    const dp = new Array(n).fill(0).map(() => new Array(k + 1).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 1; j <= k; j++) {
            if (i + 1 < j * 2) continue;
            let max = 0;
            if (i >= 1) max = dp[i - 1][j];
            const current = (i >= 2 ? dp[i - 2][j - 1] : 0) + bags[i - 1] * bags[i];
            dp[i][j] = Math.max(max, current);
        }
    }

    return dp[n - 1][k];
};