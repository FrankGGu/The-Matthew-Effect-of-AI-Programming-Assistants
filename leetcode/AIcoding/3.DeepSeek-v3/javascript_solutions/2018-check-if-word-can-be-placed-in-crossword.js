var placeWordInCrossword = function(board, word) {
    const m = board.length;
    const n = board[0].length;
    const len = word.length;

    const check = (row, col, dr, dc) => {
        let r = row, c = col;
        for (const ch of word) {
            if (r < 0 || r >= m || c < 0 || c >= n) return false;
            if (board[r][c] !== ' ' && board[r][c] !== ch) return false;
            r += dr;
            c += dc;
        }
        if (r < 0 || r >= m || c < 0 || c >= n) return true;
        return board[r][c] === '#';
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] === '#') continue;
            if ((j === 0 || board[i][j - 1] === '#') && j + len <= n) {
                if (check(i, j, 0, 1)) return true;
            }
            if ((j === n - 1 || board[i][j + 1] === '#') && j - len + 1 >= 0) {
                if (check(i, j, 0, -1)) return true;
            }
            if ((i === 0 || board[i - 1][j] === '#') && i + len <= m) {
                if (check(i, j, 1, 0)) return true;
            }
            if ((i === m - 1 || board[i + 1][j] === '#') && i - len + 1 >= 0) {
                if (check(i, j, -1, 0)) return true;
            }
        }
    }
    return false;
};