var getMoneyAmount = function(n) {
    const dp = new Array(n + 1).fill().map(() => new Array(n + 1).fill(0));

    for (let len = 2; len <= n; len++) {
        for (let start = 1; start <= n - len + 1; start++) {
            let minCost = Infinity;
            const end = start + len - 1;

            for (let pivot = start; pivot < end; pivot++) {
                const cost = pivot + Math.max(dp[start][pivot - 1], dp[pivot + 1][end]);
                minCost = Math.min(minCost, cost);
            }

            dp[start][end] = minCost;
        }
    }

    return dp[1][n];
};