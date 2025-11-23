var findDiagonalOrder = function(matrix) {
    if (!matrix || matrix.length === 0) {
        return [];
    }

    const m = matrix.length;
    const n = matrix[0].length;
    const result = [];
    let row = 0;
    let col = 0;
    let up = true;

    for (let i = 0; i < m * n; i++) {
        result.push(matrix[row][col]);

        if (up) {
            if (row - 1 >= 0 && col + 1 < n) {
                row--;
                col++;
            } else {
                up = false;
                if (col + 1 < n) {
                    col++;
                } else {
                    row++;
                }
            }
        } else {
            if (row + 1 < m && col - 1 >= 0) {
                row++;
                col--;
            } else {
                up = true;
                if (row + 1 < m) {
                    row++;
                } else {
                    col++;
                }
            }
        }
    }

    return result;
};