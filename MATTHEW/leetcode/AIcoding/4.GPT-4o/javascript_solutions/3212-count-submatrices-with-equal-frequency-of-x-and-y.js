var countEqualSubmatrices = function(matrix, x, y) {
    const m = matrix.length;
    const n = matrix[0].length;
    let count = 0;

    for (let r1 = 0; r1 < m; r1++) {
        for (let r2 = r1; r2 < m; r2++) {
            const freq = {};
            for (let c = 0; c < n; c++) {
                for (let r = r1; r <= r2; r++) {
                    if (matrix[r][c] === x || matrix[r][c] === y) {
                        freq[matrix[r][c]] = (freq[matrix[r][c]] || 0) + 1;
                    }
                }
                if (freq[x] === freq[y]) {
                    count++;
                }
                freq.x = undefined;
                freq.y = undefined;
            }
        }
    }
    return count;
};