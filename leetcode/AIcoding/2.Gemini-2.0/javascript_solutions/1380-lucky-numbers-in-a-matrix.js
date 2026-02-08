var luckyNumbers  = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;
    const minRows = new Array(m).fill(Infinity);
    const maxCols = new Array(n).fill(-Infinity);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            minRows[i] = Math.min(minRows[i], matrix[i][j]);
            maxCols[j] = Math.max(maxCols[j], matrix[i][j]);
        }
    }

    const lucky = [];
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === minRows[i] && matrix[i][j] === maxCols[j]) {
                lucky.push(matrix[i][j]);
            }
        }
    }

    return lucky;
};