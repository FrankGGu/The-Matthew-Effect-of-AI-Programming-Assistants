var solveNQueens = function(n) {
    const result = [];
    const board = Array.from({ length: n }, () => Array(n).fill('.'));

    const isSafe = (row, col) => {
        for (let i = 0; i < row; i++) {
            if (board[i][col] === 'Q') return false;
            if (col - (row - i) >= 0 && board[i][col - (row - i)] === 'Q') return false;
            if (col + (row - i) < n && board[i][col + (row - i)] === 'Q') return false;
        }
        return true;
    };

    const solve = (row) => {
        if (row === n) {
            result.push(board.map(b => b.join('')));
            return;
        }
        for (let col = 0; col < n; col++) {
            if (isSafe(row, col)) {
                board[row][col] = 'Q';
                solve(row + 1);
                board[row][col] = '.';
            }
        }
    };

    solve(0);
    return result;
};