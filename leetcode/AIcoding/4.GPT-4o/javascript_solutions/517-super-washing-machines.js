var findMinMoves = function(machines) {
    const total = machines.reduce((a, b) => a + b, 0);
    const n = machines.length;
    if (total % n !== 0) return -1;
    const target = total / n;
    let maxMoves = 0, currentSum = 0;

    for (let i = 0; i < n; i++) {
        currentSum += machines[i] - target;
        maxMoves = Math.max(maxMoves, Math.abs(currentSum), machines[i] - target);
    }

    return maxMoves;
};