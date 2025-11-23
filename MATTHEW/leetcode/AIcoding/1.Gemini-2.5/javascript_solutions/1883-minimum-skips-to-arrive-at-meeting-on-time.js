var minSkips = function(dist, speed, hoursBefore) {
    const n = dist.length;
    const dp = new Array(n + 1).fill(Infinity);
    dp[0] = 0;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j >= 0; j--) {
            let timeNoSkip = Infinity;
            if (dp[j] !== Infinity) {
                let departureTime = dp[j];
                if (i < n - 1) {
                    departureTime = Math.ceil(dp[j]);
                }
                timeNoSkip = departureTime + dist[i] / speed;
            }

            let timeSkip = Infinity;
            if (j > 0 && dp[j - 1] !== Infinity) {
                timeSkip = dp[j - 1] + dist[i] / speed;
            }

            dp[j] = Math.min(timeNoSkip, timeSkip);
        }
    }

    for (let j = 0; j <= n; j++) {
        if (dp[j] <= hoursBefore) {
            return j;
        }
    }

    return -1;
};