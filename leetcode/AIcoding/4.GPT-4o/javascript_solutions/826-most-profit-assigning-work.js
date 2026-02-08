function maxProfitAssignment(difficulty, profit, worker) {
    let jobs = difficulty.map((d, i) => [d, profit[i]]);
    jobs.sort((a, b) => a[0] - b[0]);
    worker.sort((a, b) => a - b);

    let maxProfit = 0, j = 0, bestProfit = 0;

    for (let w of worker) {
        while (j < jobs.length && jobs[j][0] <= w) {
            bestProfit = Math.max(bestProfit, jobs[j][1]);
            j++;
        }
        maxProfit += bestProfit;
    }

    return maxProfit;
}