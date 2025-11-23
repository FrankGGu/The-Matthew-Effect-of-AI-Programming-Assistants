function maxEvents(events) {
    events.sort((a, b) => a[0] - b[0]);
    const n = events.length;
    const dp = new Array(n).fill(0);
    for (let i = n - 1; i >= 0; i--) {
        let max = 0;
        let left = 0, right = i - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (events[mid][1] < events[i][0]) {
                max = Math.max(max, dp[mid]);
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        dp[i] = Math.max(max + 1, dp[i + 1] || 0);
    }
    return dp[0];
}