function minCostToHireKWorkers(quality, wage) {
    const workers = quality.map((q, i) => ({ quality: q, wage: wage[i] }));
    workers.sort((a, b) => a.wage / a.quality - b.wage / b.quality);

    let result = Infinity;
    let totalQuality = 0;
    const maxHeap = [];

    for (let i = 0; i < workers.length; i++) {
        const { quality: q, wage: w } = workers[i];
        const ratio = w / q;

        totalQuality += q;
        maxHeap.push(q);
        maxHeap.sort((a, b) => b - a);

        if (maxHeap.length > k) {
            totalQuality -= maxHeap.shift();
        }

        if (maxHeap.length === k) {
            result = Math.min(result, totalQuality * ratio);
        }
    }

    return result;
}