var checkValid = function(matrix) {
    const n = matrix.length;

    for (let i = 0; i < n; i++) {
        const rowSet = new Set();
        const colSet = new Set();

        for (let j = 0; j < n; j++) {
            if (rowSet.has(matrix[i][j])) {
                return false;
            }
            rowSet.add(matrix[i][j]);

            if (colSet.has(matrix[j][i])) {
                return false;
            }
            colSet.add(matrix[j][i]);
        }

        if (rowSet.size !== n || colSet.size !== n) {
            return false;
        }
    }

    return true;
};