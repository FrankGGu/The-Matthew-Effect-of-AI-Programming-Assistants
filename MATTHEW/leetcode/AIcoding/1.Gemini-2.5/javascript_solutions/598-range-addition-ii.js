var maxCount = function(m, n, ops) {
    let minRow = m;
    let minCol = n;

    for (let i = 0; i < ops.length; i++) {
        minRow = Math.min(minRow, ops[i][0]);
        minCol = Math.min(minCol, ops[i][1]);
    }

    return minRow * minCol;
};