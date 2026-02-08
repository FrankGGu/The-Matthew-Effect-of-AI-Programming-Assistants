function jobScheduling(startTime, endTime, profit) {
    const n = startTime.length;
    const jobs = new Array(n).fill(0).map((_, i) => [startTime[i], endTime[i], profit[i]]);
    jobs.sort((a, b) => a[1] - b[1]);

    const dp = new Array(n).fill(0);
    dp[0] = jobs[0][2];

    for (let i = 1; i < n; i++) {
        let left = 0, right = i - 1;
        let latest = -1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (jobs[mid][1] <= jobs[i][0]) {
                latest = mid;
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        if (latest != -1) {
            dp[i] = Math.max(dp[i - 1], dp[latest] + jobs[i][2]);
        } else {
            dp[i] = Math.max(dp[i - 1], jobs[i][2]);
        }
    }

    return dp[n - 1];
}