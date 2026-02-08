var isReachableAtTime = function(sx, sy, fx, fy, t) {
    if (sx === fx && sy === fy) {
        return t !== 1;
    }
    const dx = Math.abs(fx - sx);
    const dy = Math.abs(fy - sy);
    const minSteps = Math.max(dx, dy);
    return t >= minSteps;
};