var luckyNumbers  = function(matrix) {
    const m = matrix.length;
    const n = matrix[0].length;

    const minInRows = new Array(m).fill(Infinity);
    const maxInCols = new Array(n).fill(0);

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            minInRows[i] = Math.min(minInRows[i], matrix[i][j]);
            maxInCols[j] = Math.max(maxInCols[j], matrix[i][j]);
        }
    }

    const luckyNumbersList = [];

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (matrix[i][j] === minInRows[i] && matrix[i][j] === maxInCols[j]) {
                luckyNumbersList.push(matrix[i][j]);
            }
        }
    }

    return luckyNumbersList;
};