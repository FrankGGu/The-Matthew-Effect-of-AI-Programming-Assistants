var findMinMoves = function(machines) {
    const n = machines.length;
    let totalDresses = 0;
    for (let i = 0; i < n; i++) {
        totalDresses += machines[i];
    }

    if (totalDresses % n !== 0) {
        return -1;
    }

    const target = totalDresses / n;
    let maxMoves = 0;
    let currentBalanceSum = 0;

    for (let i = 0; i < n; i++) {
        const diff = machines[i] - target;
        currentBalanceSum += diff;

        // maxMoves needs to be at least the maximum surplus any single machine has
        // (dresses - target) represents how many dresses must leave this machine
        maxMoves = Math.max(maxMoves, diff); 

        // maxMoves also needs to be at least the maximum absolute net flow
        // across any point in the array. currentBalanceSum represents this net flow.
        maxMoves = Math.max(maxMoves, Math.abs(currentBalanceSum));
    }

    return maxMoves;
};