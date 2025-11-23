var maxValue = function(events, k) {
    events.sort((a, b) => a[0] - b[0]);

    const n = events.length;

    const next_idx = new Array(n).fill(n);
    for (let i = 0; i < n; i++) {
        const currentEventEndTime = events[i][1];
        let low = i + 1;
        let high = n - 1;
        let ans = n;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (events[mid][0] > currentEventEndTime) {
                ans = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        next_idx[i] = ans;
    }

    const dp = Array(n + 1).fill(0).map(() => Array(k + 1).fill(0));

    for (let i = n - 1; i >= 0; i--) {
        for (let j = 1; j <= k; j++) {
            dp[i][j] = dp[i + 1][j];

            const currentEventValue = events[i][2];
            const nextEventStartIndex = next_idx[i];

            const valIfTake = currentEventValue + dp[nextEventStartIndex][j - 1];

            dp[i][j] = Math.max(dp[i][j], valIfTake);
        }
    }

    return dp[0][k];
};