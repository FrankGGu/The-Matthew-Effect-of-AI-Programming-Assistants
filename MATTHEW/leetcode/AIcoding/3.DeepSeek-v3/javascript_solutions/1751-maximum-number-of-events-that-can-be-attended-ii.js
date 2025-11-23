var maxValue = function(events, k) {
    events.sort((a, b) => a[1] - b[1]);
    const n = events.length;
    const dp = Array.from({ length: n + 1 }, () => Array(k + 1).fill(0));

    for (let i = 1; i <= n; i++) {
        const [start, end, value] = events[i - 1];
        let l = 0, r = i - 1;
        while (l < r) {
            const mid = Math.floor((l + r) / 2);
            if (events[mid][1] < start) {
                l = mid + 1;
            } else {
                r = mid;
            }
        }
        const last = events[l][1] < start ? l + 1 : l;

        for (let j = 1; j <= k; j++) {
            dp[i][j] = Math.max(dp[i - 1][j], dp[last][j - 1] + value);
        }
    }

    return dp[n][k];
};