var totalNQueens = function(n) {
    let count = 0;
    const cols = new Set();
    const diag1 = new Set();
    const diag2 = new Set();

    const backtrack = (row) => {
        if (row === n) {
            count++;
            return;
        }
        for (let col = 0; col < n; col++) {
            const d1 = row - col;
            const d2 = row + col;
            if (cols.has(col) || diag1.has(d1) || diag2.has(d2)) continue;
            cols.add(col);
            diag1.add(d1);
            diag2.add(d2);
            backtrack(row + 1);
            cols.delete(col);
            diag1.delete(d1);
            diag2.delete(d2);
        }
    };

    backtrack(0);
    return count;
};