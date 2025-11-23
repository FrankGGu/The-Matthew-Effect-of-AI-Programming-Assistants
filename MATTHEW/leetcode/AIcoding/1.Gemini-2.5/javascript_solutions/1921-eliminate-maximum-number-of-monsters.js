var eliminateMaximum = function(dist, speed) {
    const n = dist.length;
    const arrivalTimes = new Array(n);

    for (let i = 0; i < n; i++) {
        arrivalTimes[i] = dist[i] / speed[i];
    }

    arrivalTimes.sort((a, b) => a - b);

    let eliminatedCount = 0;
    for (let i = 0; i < n; i++) {
        // If the monster arrives at or before the current minute 'i',
        // it means we cannot eliminate it.
        // We start eliminating at minute 0, then minute 1, and so on.
        // So, the i-th monster (in sorted order) is eliminated at minute i.
        // If arrivalTimes[i] <= i, it means it arrived too early.
        if (arrivalTimes[i] <= i) {
            return eliminatedCount;
        }
        eliminatedCount++;
    }

    return eliminatedCount;
};