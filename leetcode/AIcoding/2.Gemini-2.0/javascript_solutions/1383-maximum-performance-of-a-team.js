var maxPerformance = function(n, speed, efficiency, k) {
    const engineers = [];
    for (let i = 0; i < n; i++) {
        engineers.push([efficiency[i], speed[i]]);
    }
    engineers.sort((a, b) => b[0] - a[0]);

    let speedSum = 0;
    let minHeap = [];
    let performance = 0;
    const MOD = 10**9 + 7;

    for (let i = 0; i < n; i++) {
        const [currEfficiency, currSpeed] = engineers[i];
        speedSum += currSpeed;
        minHeap.push(currSpeed);
        minHeap.sort((a, b) => a - b);

        if (minHeap.length > k) {
            speedSum -= minHeap.shift();
        }

        performance = Math.max(performance, speedSum * currEfficiency);
    }

    return performance % MOD;
};