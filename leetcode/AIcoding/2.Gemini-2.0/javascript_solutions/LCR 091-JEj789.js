var minCost = function(costs) {
    if (!costs || costs.length === 0) {
        return 0;
    }

    let n = costs.length;
    let dp = [...costs[0]];

    for (let i = 1; i < n; i++) {
        let newDp = [0, 0, 0];
        newDp[0] = costs[i][0] + Math.min(dp[1], dp[2]);
        newDp[1] = costs[i][1] + Math.min(dp[0], dp[2]);
        newDp[2] = costs[i][2] + Math.min(dp[0], dp[1]);
        dp = newDp;
    }

    return Math.min(dp[0], dp[1], dp[2]);
};