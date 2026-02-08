function luckyNumbers (matrix) {
    const luckyNumbers = [];
    const rowMin = matrix.map(row => Math.min(...row));
    const colMax = matrix[0].map((_, colIndex) => Math.max(...matrix.map(row => row[colIndex])));

    for (let i = 0; i < matrix.length; i++) {
        for (let j = 0; j < matrix[i].length; j++) {
            if (matrix[i][j] === rowMin[i] && matrix[i][j] === colMax[j]) {
                luckyNumbers.push(matrix[i][j]);
            }
        }
    }

    return luckyNumbers;
}