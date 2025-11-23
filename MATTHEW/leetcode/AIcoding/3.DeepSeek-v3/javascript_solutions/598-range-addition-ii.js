var maxCount = function(m, n, ops) {
    let minRow = m;
    let minCol = n;
    for (const [a, b] of ops) {
        minRow = Math.min(minRow, a);
        minCol = Math.min(minCol, b);
    }
    return minRow * minCol;
};