var isReachableAtTime = function(sx, sy, tx, ty, t) {
    const dx = Math.abs(sx - tx);
    const dy = Math.abs(sy - ty);

    const minTime = Math.max(dx, dy);

    if (t < minTime) {
        return false;
    }

    // If start and target are the same (minTime = 0)
    // and t = 1, it's impossible (must move away and cannot return in 1 step).
    // In all other cases where t >= minTime, it's possible.
    // This can be generalized: if t - minTime is odd, it's impossible to end up at the target cell.
    // Each step changes the "parity" of being at the target cell vs. an adjacent cell.
    // If you are at a cell C at time T, to be at C again at time T+k, k must be even.
    // If k is odd, you will be at an adjacent cell.
    return (t - minTime) % 2 === 0;
};