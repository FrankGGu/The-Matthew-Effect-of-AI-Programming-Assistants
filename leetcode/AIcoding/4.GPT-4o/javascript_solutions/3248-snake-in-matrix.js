function snakePattern(matrix) {
    if (!matrix.length || !matrix[0].length) return [];
    const result = [];
    const rows = matrix.length;
    const cols = matrix[0].length;

    for (let i = 0; i < rows; i++) {
        if (i % 2 === 0) {
            for (let j = 0; j < cols; j++) {
                result.push(matrix[i][j]);
            }
        } else {
            for (let j = cols - 1; j >= 0; j--) {
                result.push(matrix[i][j]);
            }
        }
    }

    return result;
}