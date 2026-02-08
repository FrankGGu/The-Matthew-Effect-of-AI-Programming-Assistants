var totalNQueens = function(n) {
    let count = 0;

    const backtrack = (row, cols, diag1, diag2) => {
        if (row === n) {
            count++;
            return;
        }
        for (let col = 0; col < n; col++) {
            const d1 = row - col + (n - 1);
            const d2 = row + col;
            if (!cols[col] && !diag1[d1] && !diag2[d2]) {
                cols[col] = diag1[d1] = diag2[d2] = true;
                backtrack(row + 1, cols, diag1, diag2);
                cols[col] = diag1[d1] = diag2[d2] = false;
            }
        }
    };

    backtrack(0, Array(n).fill(false), Array(2 * n - 1).fill(false), Array(2 * n - 1).fill(false));
    return count;
};