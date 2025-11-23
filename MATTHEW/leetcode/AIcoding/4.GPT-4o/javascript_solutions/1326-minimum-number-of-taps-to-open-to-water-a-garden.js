var minTaps = function(n, ranges) {
    let dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < ranges.length; i++) {
        let start = Math.max(0, i - ranges[i]);
        let end = Math.min(n, i + ranges[i]);
        for (let j = start; j <= end; j++) {
            dp[end] = Math.min(dp[end], dp[j] + 1);
        }
    }

    return dp[n] === Infinity ? -1 : dp[n];
};