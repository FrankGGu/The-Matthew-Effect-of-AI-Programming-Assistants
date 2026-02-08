var mincostTickets = function(days, costs) {
    const maxDay = days[days.length - 1];
    const dp = new Array(maxDay + 1).fill(0);
    const isTravelDay = new Array(maxDay + 1).fill(false);

    for (const day of days) {
        isTravelDay[day] = true;
    }

    for (let i = 1; i <= maxDay; i++) {
        if (!isTravelDay[i]) {
            dp[i] = dp[i - 1];
            continue;
        }

        const cost1Day = dp[i - 1] + costs[0];
        const cost7Day = dp[Math.max(0, i - 7)] + costs[1];
        const cost30Day = dp[Math.max(0, i - 30)] + costs[2];

        dp[i] = Math.min(cost1Day, cost7Day, cost30Day);
    }

    return dp[maxDay];
};