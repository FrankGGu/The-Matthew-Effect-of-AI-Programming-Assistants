var mincostToHireWorkers = function(quality, wage, k) {
    const workers = quality.map((q, i) => ({
        ratio: wage[i] / q,
        quality: q
    }));
    workers.sort((a, b) => a.ratio - b.ratio);

    let minCost = Infinity;
    let qualitySum = 0;
    const maxHeap = new MaxPriorityQueue();

    for (const worker of workers) {
        qualitySum += worker.quality;
        maxHeap.enqueue(worker.quality);

        if (maxHeap.size() > k) {
            qualitySum -= maxHeap.dequeue().element;
        }

        if (maxHeap.size() === k) {
            minCost = Math.min(minCost, qualitySum * worker.ratio);
        }
    }

    return minCost;
};