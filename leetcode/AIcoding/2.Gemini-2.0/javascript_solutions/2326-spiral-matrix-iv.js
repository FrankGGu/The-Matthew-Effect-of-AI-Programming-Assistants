var spiralMatrix = function(m, n, head) {
    const matrix = Array(m).fill(null).map(() => Array(n).fill(-1));
    let rowStart = 0, rowEnd = m - 1, colStart = 0, colEnd = n - 1;

    while (head && rowStart <= rowEnd && colStart <= colEnd) {
        // Traverse right
        for (let i = colStart; i <= colEnd && head; i++) {
            matrix[rowStart][i] = head.val;
            head = head.next;
        }
        rowStart++;

        // Traverse down
        for (let i = rowStart; i <= rowEnd && head; i++) {
            matrix[i][colEnd] = head.val;
            head = head.next;
        }
        colEnd--;

        // Traverse left
        if (rowStart <= rowEnd) {
            for (let i = colEnd; i >= colStart && head; i--) {
                matrix[rowEnd][i] = head.val;
                head = head.next;
            }
        }
        rowEnd--;

        // Traverse up
        if (colStart <= colEnd) {
            for (let i = rowEnd; i >= rowStart && head; i--) {
                matrix[i][colStart] = head.val;
                head = head.next;
            }
        }
        colStart++;
    }

    return matrix;
};