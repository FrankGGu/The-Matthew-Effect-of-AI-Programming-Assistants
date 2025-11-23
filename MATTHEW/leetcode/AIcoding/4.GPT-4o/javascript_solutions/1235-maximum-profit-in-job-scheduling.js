class Job {
    constructor(start, end, profit) {
        this.start = start;
        this.end = end;
        this.profit = profit;
    }
}

function jobScheduling(startTime, endTime, profit) {
    const jobs = [];
    for (let i = 0; i < startTime.length; i++) {
        jobs.push(new Job(startTime[i], endTime[i], profit[i]));
    }

    jobs.sort((a, b) => a.end - b.end);

    const dp = new Array(jobs.length).fill(0);
    dp[0] = jobs[0].profit;

    const findLastNonConflict = (index) => {
        let low = 0, high = index - 1;
        while (low <= high) {
            const mid = Math.floor((low + high) / 2);
            if (jobs[mid].end <= jobs[index].start) {
                if (jobs[mid + 1].end <= jobs[index].start) {
                    low = mid + 1;
                } else {
                    return mid;
                }
            } else {
                high = mid - 1;
            }
        }
        return -1;
    };

    for (let i = 1; i < jobs.length; i++) {
        const profitIncludingCurrent = jobs[i].profit;
        const lastNonConflictIndex = findLastNonConflict(i);
        if (lastNonConflictIndex !== -1) {
            profitIncludingCurrent += dp[lastNonConflictIndex];
        }
        dp[i] = Math.max(profitIncludingCurrent, dp[i - 1]);
    }

    return dp[jobs.length - 1];
}