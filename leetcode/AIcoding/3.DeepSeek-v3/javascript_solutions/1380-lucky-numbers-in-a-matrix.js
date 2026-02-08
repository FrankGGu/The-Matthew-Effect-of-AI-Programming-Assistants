var luckyNumbers  = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const minRow = new Array(m).fill(Infinity);
    const maxCol = new Array(n).fill(-Infinity);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            minRow[i] = Math.min(minRow[i], matrix[i][j]);
            maxCol[j] = Math.max(maxCol[j], matrix[i][j]);
        }
    }

    const result = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === minRow[i] && matrix[i][j] === maxCol[j]) {
                result.push(matrix[i][j]);
            }
        }
    }

    return result;
};