var maxPerformance = function(n, speed, efficiency, k) {
    const engineers = [];
    for (let i = 0; i < n; i++) {
        engineers.push({ speed: speed[i], efficiency: efficiency[i] });
    }
    engineers.sort((a, b) => b.efficiency - a.efficiency);

    const minHeap = new MinPriorityQueue();
    let totalSpeed = 0;
    let maxPerf = 0;
    const MOD = 1e9 + 7;

    for (const eng of engineers) {
        if (minHeap.size() === k) {
            totalSpeed -= minHeap.dequeue().element;
        }
        minHeap.enqueue(eng.speed);
        totalSpeed += eng.speed;
        maxPerf = Math.max(maxPerf, totalSpeed * eng.efficiency);
    }

    return maxPerf % MOD;
};