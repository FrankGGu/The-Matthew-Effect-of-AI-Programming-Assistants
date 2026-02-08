var maxValue = function(events, k) {
    events.sort((a, b) => a[0] - b[0]);
    const n = events.length;
    const dp = Array(n + 1).fill(null).map(() => Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        for (let j = 1; j <= k; j++) {
            const [start, end, value] = events[i - 1];
            let nextEventIndex = -1;
            let low = 0;
            let high = i - 2;
            while (low <= high) {
                const mid = Math.floor((low + high) / 2);
                if (events[mid][1] < start) {
                    nextEventIndex = mid;
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

            if (nextEventIndex === -1) {
                dp[i][j] = Math.max(dp[i - 1][j], value);
            } else {
                dp[i][j] = Math.max(dp[i - 1][j], value + dp[nextEventIndex + 1][j - 1]);
            }
        }
    }

    return dp[n][k];
};