var maxEqualRowsAfterFlips = function(matrix) {
    const map = new Map();
    for (const row of matrix) {
        let key = '';
        const first = row[0];
        for (const num of row) {
            key += num === first ? '1' : '0';
        }
        map.set(key, (map.get(key) || 0) + 1);
    }
    return Math.max(...map.values());
};