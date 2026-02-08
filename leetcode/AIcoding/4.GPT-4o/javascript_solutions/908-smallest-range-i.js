var smallestRangeI = function(A, K) {
    const max = Math.max(...A);
    const min = Math.min(...A);
    return Math.max(0, max - min - 2 * K);
};