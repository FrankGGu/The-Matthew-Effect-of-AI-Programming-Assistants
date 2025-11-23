function maxPerformance(n, engineers, speedLimit, efficiency) {
    const team = engineers.map((e, i) => [efficiency[i], speedLimit[i]]);
    team.sort((a, b) => b[0] - a[0]);

    let maxPerformance = 0;
    let totalSpeed = 0;
    const minHeap = [];

    for (let i = 0; i < n; i++) {
        const [eff, spd] = team[i];
        totalSpeed += spd;
        maxPerformance = Math.max(maxPerformance, totalSpeed * eff);

        minHeap.push(spd);
        minHeap.sort((a, b) => a - b);

        if (minHeap.length > team.length) {
            totalSpeed -= minHeap.shift();
        }
    }

    return maxPerformance;
}