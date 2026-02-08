var mincostTickets = function(days, costs) {
    const lastDay = days[days.length - 1];
    const daysSet = new Set(days);
    const dp = new Array(lastDay + 1).fill(0);

    for (let i = 1; i <= lastDay; i++) {
        if (!daysSet.has(i)) {
            dp[i] = dp[i - 1];
        } else {
            dp[i] = Math.min(
                dp[Math.max(0, i - 1)] + costs[0],
                dp[Math.max(0, i - 7)] + costs[1],
                dp[Math.max(0, i - 30)] + costs[2]
            );
        }
    }

    return dp[lastDay];
};