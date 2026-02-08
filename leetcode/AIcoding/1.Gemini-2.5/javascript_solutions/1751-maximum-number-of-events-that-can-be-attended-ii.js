var maxValue = function(events, k) {
    events.sort((a, b) => a[0] - b[0]);

    const n = events.length;

    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = dp[i + 1][j];

            let low = i + 1;
            let high = n - 1;
            let nextCompatibleEventIndex = n;

            while (low <= high) {
                const mid = Math.floor((low + high) / 2);
                if (events[mid][0] > events[i][1]) {
                    nextCompatibleEventIndex = mid;
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            }

            dp[i][j] = Math.max(dp[i][j], events[i][2] + dp[nextCompatibleEventIndex][j - 1]);
        }
    }

    return dp[0][k];
};