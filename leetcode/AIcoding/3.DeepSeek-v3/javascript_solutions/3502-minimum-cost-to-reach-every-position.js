var minCost = function(costs) {
    if (!costs || costs.length === 0) return 0;
    const n = costs.length;
    const m = costs[0].length;
    let dp = new Array(m).fill(0);

    for (let i = 0; i < m; i++) {
        dp[i] = costs[0][i];
    }

    for (let i = 1; i < n; i++) {
        let newDp = new Array(m).fill(0);
        for (let j = 0; j < m; j++) {
            let minPrev = Infinity;
            for (let k = 0; k < m; k++) {
                if (k !== j) {
                    minPrev = Math.min(minPrev, dp[k]);
                }
            }
            newDp[j] = costs[i][j] + minPrev;
        }
        dp = newDp;
    }

    return Math.min(...dp);
};