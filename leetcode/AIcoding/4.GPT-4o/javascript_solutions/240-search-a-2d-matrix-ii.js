function searchMatrix(matrix, target) {
    if (!matrix.length || !matrix[0].length) return false;
    let row = matrix.length - 1;
    let col = 0;

    while (row >= 0 && col < matrix[0].length) {
        if (matrix[row][col] === target) {
            return true;
        } else if (matrix[row][col] > target) {
            row--;
        } else {
            col++;
        }
    }
    return false;
}