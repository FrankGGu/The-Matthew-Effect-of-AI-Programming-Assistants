var maxEqualRowsAfterFlips = function(mat) {
    const m = mat.length;
    if (m === 0) {
        return 0;
    }

    const map = new Map();
    let maxCount = 0;

    for (let i = 0; i < m; i++) {
        const currentRow = mat[i];
        const n = currentRow.length;
        let canonicalRow = new Array(n);

        if (currentRow[0] === 0) {
            // If the first element is 0, use the row as is
            for (let j = 0; j < n; j++) {
                canonicalRow[j] = currentRow[j];
            }
        } else {
            // If the first element is 1, flip the entire row
            for (let j = 0; j < n; j++) {
                canonicalRow[j] = 1 - currentRow[j];
            }
        }

        const key = canonicalRow.join(',');
        map.set(key, (map.get(key) || 0) + 1);
        maxCount = Math.max(maxCount, map.get(key));
    }

    return maxCount;
};