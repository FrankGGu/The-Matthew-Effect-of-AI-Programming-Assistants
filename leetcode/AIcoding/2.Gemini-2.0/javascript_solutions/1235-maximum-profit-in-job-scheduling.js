var jobScheduling = function(startTime, endTime, profit) {
    const jobs = [];
    for (let i = 0; i < startTime.length; i++) {
        jobs.push({ start: startTime[i], end: endTime[i], profit: profit[i] });
    }

    jobs.sort((a, b) => a.end - b.end);

    const dp = new Array(jobs.length).fill(0);
    dp[0] = jobs[0].profit;

    for (let i = 1; i < jobs.length; i++) {
        let currentProfit = jobs[i].profit;
        let prevIndex = -1;

        let low = 0;
        let high = i - 1;

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (jobs[mid].end <= jobs[i].start) {
                prevIndex = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }

        if (prevIndex !== -1) {
            currentProfit += dp[prevIndex];
        }

        dp[i] = Math.max(dp[i - 1], currentProfit);
    }

    return dp[jobs.length - 1];
};