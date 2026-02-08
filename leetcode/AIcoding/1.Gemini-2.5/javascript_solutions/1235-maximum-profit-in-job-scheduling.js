var jobScheduling = function(startTime, endTime, profit) {
    const n = startTime.length;
    const jobs = [];
    for (let i = 0; i < n; i++) {
        jobs.push({ start: startTime[i], end: endTime[i], profit: profit[i] });
    }

    jobs.sort((a, b) => a.end - b.end);

    const dp = [[0, 0]]; 

    for (const job of jobs) {
        let low = 0;
        let high = dp.length - 1;
        let prevProfitIndex = 0;

        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (dp[mid][0] <= job.start) {
                prevProfitIndex = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        const currentProfit = job.profit + dp[prevProfitIndex][1];

        if (currentProfit > dp[dp.length - 1][1]) {
            dp.push([job.end, currentProfit]);
        }
    }

    return dp[dp.length - 1][1];
};