var minDeletionSize = function(A) {
    const m = A.length, n = A[0].length;
    const toDelete = new Set();
    for (let j = 0; j < n; j++) {
        for (let i = 1; i < m; i++) {
            if (toDelete.has(j) || (A[i][j] < A[i - 1][j])) {
                toDelete.add(j);
                break;
            }
        }
    }
    return toDelete.size;
};