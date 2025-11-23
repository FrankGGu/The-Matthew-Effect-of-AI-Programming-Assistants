var mincostTickets = function(days, costs) {
    const dp = new Array(days[days.length - 1] + 1).fill(0);
    const daySet = new Set(days);

    for (let i = 1; i < dp.length; i++) {
        if (!daySet.has(i)) {
            dp[i] = dp[i - 1];
            continue;
        }
        dp[i] = Math.min(dp[Math.max(0, i - 1)] + costs[0], 
                         dp[Math.max(0, i - 7)] + costs[1], 
                         dp[Math.max(0, i - 30)] + costs[2]);
    }

    return dp[dp.length - 1];
};