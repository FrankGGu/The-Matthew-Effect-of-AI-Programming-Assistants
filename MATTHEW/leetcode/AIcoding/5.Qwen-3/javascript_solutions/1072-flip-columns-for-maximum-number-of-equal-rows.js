function maxEqualRowsAfterFlip(matrix) {
    const map = new Map();
    for (const row of matrix) {
        let key = '';
        for (let i = 0; i < row.length; i++) {
            if (row[0] === 1) {
                key += row[i] === 1 ? '1' : '0';
            } else {
                key += row[i] === 1 ? '0' : '1';
            }
        }
        map.set(key, (map.get(key) || 0) + 1);
    }
    return Math.max(...Array.from(map.values()));
}