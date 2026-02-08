var maxEqualRowsAfterFlips = function(matrix) {
    const map = new Map();
    for (const row of matrix) {
        const key = row.map((val, i) => val ^ row[0]).join(',');
        map.set(key, (map.get(key) || 0) + 1);
    }
    return Math.max(...map.values());
};