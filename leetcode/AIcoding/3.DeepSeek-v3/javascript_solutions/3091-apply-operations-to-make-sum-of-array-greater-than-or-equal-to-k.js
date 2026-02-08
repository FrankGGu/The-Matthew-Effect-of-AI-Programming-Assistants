var minOperations = function(k) {
    if (k === 1) return 0;
    let minOps = Infinity;
    for (let a = 1; a <= k; a++) {
        const b = Math.ceil(k / a);
        const ops = (a - 1) + (b - 1);
        if (ops < minOps) {
            minOps = ops;
        }
    }
    return minOps;
};