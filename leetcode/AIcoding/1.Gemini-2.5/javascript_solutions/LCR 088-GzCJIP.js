var minCostClimbingStairs = function(cost) {
    const n = cost.length;

    let dp_i_plus_2 = 0; // Represents dp[i+2]
    let dp_i_plus_1 = 0; // Represents dp[i+1]

    for (let i = n - 1; i >= 0; i--) {
        const current_cost = cost[i] + Math.min(dp_i_plus_1, dp_i_plus_2);
        dp_i_plus_2 = dp_i_plus_1;
        dp_i_plus_1 = current_cost;
    }

    return Math.min(dp_i_plus_1, dp_i_plus_2);
};