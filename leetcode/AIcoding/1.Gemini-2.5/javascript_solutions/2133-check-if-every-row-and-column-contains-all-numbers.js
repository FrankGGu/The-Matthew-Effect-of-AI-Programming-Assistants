var checkValid = function(matrix) {
    const n = matrix.length;

    for (let i = 0; i < n; i++) {
        const rowSeen = new Set();
        const colSeen = new Set();
        for (let j = 0; j < n; j++) {
            const rowNum = matrix[i][j];
            if (rowSeen.has(rowNum)) {
                return false;
            }
            rowSeen.add(rowNum);

            const colNum = matrix[j][i]; // Note: matrix[j][i] to check column elements
            if (colSeen.has(colNum)) {
                return false;
            }
            colSeen.add(colNum);
        }
    }

    return true;
};