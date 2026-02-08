var maxValue = function(events, k) {
    events.sort((a, b) => a[1] - b[1]);
    const dp = Array.from({ length: k + 1 }, () => new Array(events.length + 1).fill(0));

    for (let i = 1; i <= k; i++) {
        for (let j = 1; j <= events.length; j++) {
            dp[i][j] = dp[i][j - 1];
            let l = 0, r = j - 1;
            while (l < r) {
                const mid = Math.floor((l + r) / 2);
                if (events[mid][1] < events[j - 1][0]) {
                    l = mid + 1;
                } else {
                    r = mid;
                }
            }
            if (events[l][1] < events[j - 1][0]) {
                dp[i][j] = Math.max(dp[i][j], dp[i - 1][l + 1] + events[j - 1][2]);
            }
        }
    }
    return dp[k][events.length];
};