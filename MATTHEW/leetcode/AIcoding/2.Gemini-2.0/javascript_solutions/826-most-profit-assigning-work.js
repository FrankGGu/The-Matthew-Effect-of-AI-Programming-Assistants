var maxProfitAssignment = function(difficulty, profit, worker) {
    let jobs = [];
    for (let i = 0; i < difficulty.length; i++) {
        jobs.push([difficulty[i], profit[i]]);
    }

    jobs.sort((a, b) => a[0] - b[0]);
    worker.sort((a, b) => a - b);

    let maxProfit = 0;
    let j = 0;
    let bestProfit = 0;

    for (let i = 0; i < worker.length; i++) {
        while (j < jobs.length && jobs[j][0] <= worker[i]) {
            bestProfit = Math.max(bestProfit, jobs[j][1]);
            j++;
        }
        maxProfit += bestProfit;
    }

    return maxProfit;
};