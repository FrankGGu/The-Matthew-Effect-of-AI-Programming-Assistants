var mincostToHireWorkers = function(quality, wage, k) {
    const n = quality.length;
    const workers = [];
    for (let i = 0; i < n; i++) {
        workers.push([wage[i] / quality[i], quality[i]]);
    }
    workers.sort((a, b) => a[0] - b[0]);

    let totalQuality = 0;
    let pq = new MaxPriorityQueue({ priority: x => x });
    let minCost = Infinity;

    for (let i = 0; i < n; i++) {
        const ratio = workers[i][0];
        const currQuality = workers[i][1];

        pq.enqueue(currQuality);
        totalQuality += currQuality;

        if (pq.size() > k) {
            totalQuality -= pq.dequeue().element;
        }

        if (pq.size() === k) {
            minCost = Math.min(minCost, ratio * totalQuality);
        }
    }

    return minCost;
};