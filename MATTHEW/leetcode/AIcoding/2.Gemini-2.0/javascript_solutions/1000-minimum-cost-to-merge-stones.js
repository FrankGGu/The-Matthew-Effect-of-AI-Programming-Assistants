var mergeStones = function(stones, k) {
    const n = stones.length;
    if ((n - 1) % (k - 1) !== 0) {
        return -1;
    }

    const prefixSum = new Array(n + 1).fill(0);
    for (let i = 0; i < n; i++) {
        prefixSum[i + 1] = prefixSum[i] + stones[i];
    }

    const dp = Array(n).fill(null).map(() => Array(n).fill(null));

    function solve(i, j) {
        if (i === j) {
            return 0;
        }

        if (dp[i][j] !== null) {
            return dp[i][j];
        }

        let minCost = Infinity;
        for (let m = i; m < j; m += (k - 1)) {
            minCost = Math.min(minCost, solve(i, m) + solve(m + 1, j));
        }

        if ((j - i) % (k - 1) === 0) {
            minCost += prefixSum[j + 1] - prefixSum[i];
        }

        dp[i][j] = minCost;
        return minCost;
    }

    return solve(0, n - 1);
};