var areSimilar = function(matrix, k) {
    const m = matrix.length;
    const n = matrix[0].length;

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] !== matrix[i][(j + k) % n]) {
                return false;
            }
        }
    }

    return true;
};