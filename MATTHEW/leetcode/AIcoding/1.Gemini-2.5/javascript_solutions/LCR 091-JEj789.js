var minCost = function(costs) {
    if (!costs || costs.length === 0) {
        return 0;
    }

    const n = costs.length;

    let dp0 = costs[0][0];
    let dp1 = costs[0][1];
    let dp2 = costs[0][2];

    for (let i = 1; i < n; i++) {
        let new_dp0 = costs[i][0] + Math.min(dp1, dp2);
        let new_dp1 = costs[i][1] + Math.min(dp0, dp2);
        let new_dp2 = costs[i][2] + Math.min(dp0, dp1);

        dp0 = new_dp0;
        dp1 = new_dp1;
        dp2 = new_dp2;
    }

    return Math.min(dp0, dp1, dp2);
};