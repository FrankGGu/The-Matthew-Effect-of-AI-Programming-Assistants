var isReachableAtTime = function(sx, sy, fx, fy, t) {
    const dx = Math.abs(sx - fx);
    const dy = Math.abs(sy - fy);
    const maxDiff = Math.max(dx, dy);

    if (maxDiff === 0) {
        return t !== 1;
    }

    return maxDiff <= t;
};