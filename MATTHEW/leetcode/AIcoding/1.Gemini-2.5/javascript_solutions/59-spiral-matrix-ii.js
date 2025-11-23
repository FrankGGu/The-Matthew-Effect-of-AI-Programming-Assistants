var generateMatrix = function(n) {
    const matrix = Array.from({ length: n }, () => Array(n).fill(0));

    let num = 1;
    let rowStart = 0;
    let rowEnd = n - 1;
    let colStart = 0;
    let colEnd = n - 1;

    while (rowStart <= rowEnd && colStart <= colEnd) {
        // Traverse Right
        for (let c = colStart; c <= colEnd; c++) {
            matrix[rowStart][c] = num++;
        }
        rowStart++;

        // Traverse Down
        for (let r = rowStart; r <= rowEnd; r++) {
            matrix[r][colEnd] = num++;
        }
        colEnd--;

        // Traverse Left
        if (rowStart <= rowEnd) {
            for (let c = colEnd; c >= colStart; c--) {
                matrix[rowEnd][c] = num++;
            }
            rowEnd--;
        }

        // Traverse Up
        if (colStart <= colEnd) {
            for (let r = rowEnd; r >= rowStart; r--) {
                matrix[r][colStart] = num++;
            }
            colStart++;
        }
    }

    return matrix;
};