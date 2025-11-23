var maxProfitAssignment = function(difficulty, profit, worker) {
    const jobs = difficulty.map((d, i) => ({ d, p: profit[i] }));
    jobs.sort((a, b) => a.d - b.d);
    worker.sort((a, b) => a - b);

    let maxProfit = 0;
    let totalProfit = 0;
    let jobIndex = 0;

    for (const ability of worker) {
        while (jobIndex < jobs.length && jobs[jobIndex].d <= ability) {
            maxProfit = Math.max(maxProfit, jobs[jobIndex].p);
            jobIndex++;
        }
        totalProfit += maxProfit;
    }

    return totalProfit;
};