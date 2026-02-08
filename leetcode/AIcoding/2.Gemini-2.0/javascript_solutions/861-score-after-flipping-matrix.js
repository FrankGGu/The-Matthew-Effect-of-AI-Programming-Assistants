var matrixScore = function(matrix) {
    let m = matrix.length;
    let n = matrix[0].length;

    for (let i = 0; i < m; i++) {
        if (matrix[i][0] === 0) {
            for (let j = 0; j < n; j++) {
                matrix[i][j] = 1 - matrix[i][j];
            }
        }
    }

    for (let j = 1; j < n; j++) {
        let count = 0;
        for (let i = 0; i < m; i++) {
            if (matrix[i][j] === 0) {
                count++;
            }
        }
        if (count < m - count) {
            for (let i = 0; i < m; i++) {
                matrix[i][j] = 1 - matrix[i][j];
            }
        }
    }

    let score = 0;
    for (let i = 0; i < m; i++) {
        let rowValue = 0;
        for (let j = 0; j < n; j++) {
            rowValue = rowValue * 2 + matrix[i][j];
        }
        score += rowValue;
    }

    return score;
};