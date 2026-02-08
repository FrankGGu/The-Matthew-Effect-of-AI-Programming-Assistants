var numberOfChild = function(n, k) {
    if (n === 1) {
        return 0;
    }

    const cycleLength = 2 * (n - 1);
    const effectiveK = k % cycleLength;

    if (effectiveK < n) {
        return effectiveK;
    } else {
        return cycleLength - effectiveK;
    }
};