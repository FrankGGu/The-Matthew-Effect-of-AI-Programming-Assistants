function countNegativeNumbersOnSortedMatrix(matrix) {
    let count = 0;
    const rows = matrix.length;
    const cols = matrix[0].length;
    let row = 0;
    let col = cols - 1;

    while (row < rows && col >= 0) {
        if (matrix[row][col] < 0) {
            count += rows - row;
            col--;
        } else {
            row++;
        }
    }

    return count;
}