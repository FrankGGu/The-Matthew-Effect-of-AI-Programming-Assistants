var totalNQueens = function(n) {
    let count = 0;

    function isSafe(board, row, col, n) {
        for (let i = 0; i < row; i++) {
            if (board[i][col] === 'Q') {
                return false;
            }
            if (col - (row - i) >= 0 && board[i][col - (row - i)] === 'Q') {
                return false;
            }
            if (col + (row - i) < n && board[i][col + (row - i)] === 'Q') {
                return false;
            }
        }
        return true;
    }

    function solveNQueensUtil(board, row, n) {
        if (row === n) {
            count++;
            return;
        }

        for (let col = 0; col < n; col++) {
            if (isSafe(board, row, col, n)) {
                board[row][col] = 'Q';
                solveNQueensUtil(board, row + 1, n);
                board[row][col] = '.';
            }
        }
    }

    let board = Array(n).fill(null).map(() => Array(n).fill('.'));
    solveNQueensUtil(board, 0, n);
    return count;
};