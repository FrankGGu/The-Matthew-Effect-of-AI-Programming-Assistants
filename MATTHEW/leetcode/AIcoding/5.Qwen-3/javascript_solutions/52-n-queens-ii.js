var totalNQueens = function(n) {
    const result = [0];
    const board = new Array(n).fill(0).map(() => new Array(n).fill(0));

    function isSafe(row, col) {
        for (let i = 0; i < row; i++) {
            if (board[i][col] === 1) return false;
        }
        for (let i = row, j = col; i >= 0 && j >= 0; i--, j--) {
            if (board[i][j] === 1) return false;
        }
        for (let i = row, j = col; i >= 0 && j < n; i--, j++) {
            if (board[i][j] === 1) return false;
        }
        return true;
    }

    function backtrack(row) {
        if (row === n) {
            result[0]++;
            return;
        }
        for (let col = 0; col < n; col++) {
            if (isSafe(row, col)) {
                board[row][col] = 1;
                backtrack(row + 1);
                board[row][col] = 0;
            }
        }
    }

    backtrack(0);
    return result[0];
};