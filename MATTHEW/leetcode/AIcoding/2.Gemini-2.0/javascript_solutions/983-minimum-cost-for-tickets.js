var mincostTickets = function(days, costs) {
    const n = days.length;
    const dp = new Array(n + 1).fill(0);

    for (let i = 1; i <= n; i++) {
        dp[i] = dp[i - 1] + costs[0];

        let j = i - 1;
        while (j >= 0 && days[i - 1] - days[j] < 7) {
            j--;
        }
        dp[i] = Math.min(dp[i], (j >= 0 ? dp[j + 1] : 0) + costs[1]);

        j = i - 1;
        while (j >= 0 && days[i - 1] - days[j] < 30) {
            j--;
        }
        dp[i] = Math.min(dp[i], (j >= 0 ? dp[j + 1] : 0) + costs[2]);
    }

    return dp[n];
};