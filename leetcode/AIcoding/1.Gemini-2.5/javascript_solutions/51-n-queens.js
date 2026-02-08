var solveNQueens = function(n) {
    const results = [];
    const board = Array(n).fill(null).map(() => Array(n).fill('.'));

    const cols = new Set();
    const diag1 = new Set(); // r - c
    const diag2 = new Set(); // r + c

    function backtrack(r) {
        if (r === n) {
            results.push(board.map(row => row.join('')));
            return;
        }

        for (let c = 0; c < n; c++) {
            if (cols.has(c) || diag1.has(r - c) || diag2.has(r + c)) {
                continue;
            }

            board[r][c] = 'Q';
            cols.add(c);
            diag1.add(r - c);
            diag2.add(r + c);

            backtrack(r + 1);

            board[r][c] = '.';
            cols.delete(c);
            diag1.delete(r - c);
            diag2.delete(r + c);
        }
    }

    backtrack(0);
    return results;
};