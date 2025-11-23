var maxTwoEvents = function(events) {
    events.sort((a, b) => a[1] - b[1]);
    let maxEvent = 0;
    let maxProfit = 0;
    let dp = new Array(events.length).fill(0);

    for (let i = 0; i < events.length; i++) {
        dp[i] = events[i][2];
        maxEvent = Math.max(maxEvent, dp[i]);
        for (let j = 0; j < i; j++) {
            if (events[j][1] < events[i][0]) {
                dp[i] = Math.max(dp[i], dp[j] + events[i][2]);
            }
        }
        maxProfit = Math.max(maxProfit, dp[i]);
    }

    return maxProfit;
};