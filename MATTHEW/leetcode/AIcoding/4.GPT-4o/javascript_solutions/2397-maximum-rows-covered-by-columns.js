var maximumRows = function(matrix, numSelect) {
    const m = matrix.length, n = matrix[0].length;
    let maxRows = 0;

    const dfs = (start, selected, rowMask) => {
        if (selected === numSelect) {
            let count = 0;
            for (let i = 0; i < m; i++) {
                if ((rowMask & (1 << i)) === 0) {
                    count++;
                }
            }
            maxRows = Math.max(maxRows, count);
            return;
        }
        for (let i = start; i < n; i++) {
            dfs(i + 1, selected + 1, rowMask | getRowMask(i));
        }
    };

    const getRowMask = (col) => {
        let mask = 0;
        for (let row = 0; row < m; row++) {
            if (matrix[row][col] === 1) {
                mask |= (1 << row);
            }
        }
        return mask;
    };

    dfs(0, 0, 0);
    return maxRows;
};