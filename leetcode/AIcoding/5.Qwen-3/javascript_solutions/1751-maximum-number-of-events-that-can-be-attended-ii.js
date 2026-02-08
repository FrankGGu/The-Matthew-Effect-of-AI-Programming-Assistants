function maxEvents(events) {
    events.sort((a, b) => a[1] - b[1]);
    const n = events.length;
    const dp = new Array(n).fill(0);
    const last = new Array(n).fill(-1);

    for (let i = 0; i < n; i++) {
        let low = 0, high = i - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (events[mid][1] < events[i][0]) {
                last[i] = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
    }

    for (let i = 0; i < n; i++) {
        dp[i] = 1;
        if (last[i] !== -1) {
            dp[i] = Math.max(dp[i], dp[last[i]] + 1);
        }
        if (i > 0) {
            dp[i] = Math.max(dp[i], dp[i - 1]);
        }
    }

    return dp[n - 1];
}