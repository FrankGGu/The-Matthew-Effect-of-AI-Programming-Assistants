var jobScheduling = function(startTime, endTime, profit) {
    const jobs = [];
    for (let i = 0; i < startTime.length; i++) {
        jobs.push({ start: startTime[i], end: endTime[i], profit: profit[i] });
    }
    jobs.sort((a, b) => a.end - b.end);

    const dp = [];
    dp.push({ end: 0, profit: 0 });

    for (const job of jobs) {
        let left = 0, right = dp.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (dp[mid].end <= job.start) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        const maxProfit = dp[right].profit + job.profit;
        if (maxProfit > dp[dp.length - 1].profit) {
            dp.push({ end: job.end, profit: maxProfit });
        }
    }

    return dp[dp.length - 1].profit;
};