var maxEqualRowsAfterFlips = function(matrix) {
    const n = matrix.length;
    const m = matrix[0].length;
    const count = new Map();
    let ans = 0;

    for (let i = 0; i < n; i++) {
        let key = "";
        for (let j = 0; j < m; j++) {
            key += (matrix[i][0] ^ matrix[i][j]);
        }
        count.set(key, (count.get(key) || 0) + 1);
        ans = Math.max(ans, count.get(key));
    }

    return ans;
};