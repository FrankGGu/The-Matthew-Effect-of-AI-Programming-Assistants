var maximizeTheProfit = function(n, offers) {
    let dp = new Array(n).fill(0);
    let offersByEnd = new Array(n).fill(0).map(() => []);

    for (const [start, end, profit] of offers) {
        offersByEnd[end].push([start, profit]);
    }

    for (let i = 0; i < n; i++) {
        // Option 1: Do not take any offer ending at house i.
        // The maximum profit up to house i is the same as up to house i-1.
        if (i > 0) {
            dp[i] = dp[i - 1];
        }

        // Option 2: Consider taking offers that end at house i.
        for (const [start, profit] of offersByEnd[i]) {
            let prevProfit = (start > 0) ? dp[start - 1] : 0;
            dp[i] = Math.max(dp[i], prevProfit + profit);
        }
    }

    return dp[n - 1];
};