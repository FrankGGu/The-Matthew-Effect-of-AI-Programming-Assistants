var maxPerformance = function(n, speed, efficiency, k) {
    const MOD = 10 ** 9 + 7;
    const engineers = [];

    for (let i = 0; i < n; i++) {
        engineers.push([efficiency[i], speed[i]]);
    }

    engineers.sort((a, b) => b[0] - a[0]);

    let speedSum = 0;
    const minHeap = new MinPriorityQueue();
    let maxPerformance = 0;

    for (let i = 0; i < n; i++) {
        const [eff, spd] = engineers[i];
        speedSum += spd;
        minHeap.enqueue(spd);

        if (minHeap.size() > k) {
            speedSum -= minHeap.dequeue().element;
        }

        maxPerformance = Math.max(maxPerformance, speedSum * eff);
    }

    return maxPerformance % MOD;
};