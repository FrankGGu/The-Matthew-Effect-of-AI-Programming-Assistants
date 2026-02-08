var findDiagonalOrder = function(mat) {
    if (mat.length === 0) return [];
    const m = mat.length;
    const n = mat[0].length;
    const result = [];
    let row = 0, col = 0;
    let direction = 1; // 1 for up, -1 for down

    for (let i = 0; i < m * n; i++) {
        result.push(mat[row][col]);
        if (direction === 1) {
            if (col === n - 1) {
                row++;
                direction = -1;
            } else if (row === 0) {
                col++;
                direction = -1;
            } else {
                row--;
                col++;
            }
        } else {
            if (row === m - 1) {
                col++;
                direction = 1;
            } else if (col === 0) {
                row++;
                direction = 1;
            } else {
                row++;
                col--;
            }
        }
    }
    return result;
};