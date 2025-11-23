var maxScore = function(intervals) {
    intervals.sort((a, b) => a[1] - b[1]);
    let dp = [];
    dp[0] = intervals[0][2];
    for (let i = 1; i < intervals.length; i++) {
        let current = intervals[i][2];
        let l = 0, r = i - 1, lastNonOverlapping = -1;
        while (l <= r) {
            let mid = Math.floor((l + r) / 2);
            if (intervals[mid][1] <= intervals[i][0]) {
                lastNonOverlapping = mid;
                l = mid + 1;
            } else {
                r = mid - 1;
            }
        }
        if (lastNonOverlapping !== -1) {
            current += dp[lastNonOverlapping];
        }
        dp[i] = Math.max(current, dp[i - 1]);
    }
    return dp[intervals.length - 1];
};