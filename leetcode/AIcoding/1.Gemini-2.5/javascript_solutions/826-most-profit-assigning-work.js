var maxProfitAssignment = function(difficulty, profit, worker) {
    const n = difficulty.length;
    const m = worker.length;

    const jobs = [];
    for (let i = 0; i < n; i++) {
        jobs.push([difficulty[i], profit[i]]);
    }

    jobs.sort((a, b) => a[0] - b[0]);

    for (let i = 1; i < n; i++) {
        jobs[i][1] = Math.max(jobs[i][1], jobs[i - 1][1]);
    }

    worker.sort((a, b) => a - b);

    let totalProfit = 0;
    let jobIndex = 0;
    let currentMaxProfit = 0;

    for (let i = 0; i < m; i++) {
        const workerAbility = worker[i];

        while (jobIndex < n && jobs[jobIndex][0] <= workerAbility) {
            currentMaxProfit = Math.max(currentMaxProfit, jobs[jobIndex][1]);
            jobIndex++;
        }

        totalProfit += currentMaxProfit;
    }

    return totalProfit;
};