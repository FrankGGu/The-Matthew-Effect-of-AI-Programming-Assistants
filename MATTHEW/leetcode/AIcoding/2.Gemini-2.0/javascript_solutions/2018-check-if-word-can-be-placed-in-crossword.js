var placeWordInCrossword = function(board, word) {
    const m = board.length;
    const n = board[0].length;
    const wordLen = word.length;

    const checkHorizontal = (row, col, dir) => {
        if (dir === 1) {
            if (col + wordLen > n) return false;
            if (col > 0 && board[row][col - 1] !== '#') return false;
            if (col + wordLen < n && board[row][col + wordLen] !== '#') return false;
            for (let i = 0; i < wordLen; i++) {
                if (board[row][col + i] !== ' ' && board[row][col + i] !== word[i]) return false;
            }
            return true;
        } else {
            if (col - wordLen + 1 < 0) return false;
            if (col + 1 < n && board[row][col + 1] !== '#') return false;
            if (col - wordLen >= 0 && board[row][col - wordLen] !== '#') return false;
            for (let i = 0; i < wordLen; i++) {
                if (board[row][col - i] !== ' ' && board[row][col - i] !== word[i]) return false;
            }
            return true;
        }
    };

    const checkVertical = (row, col, dir) => {
        if (dir === 1) {
            if (row + wordLen > m) return false;
            if (row > 0 && board[row - 1][col] !== '#') return false;
            if (row + wordLen < m && board[row + wordLen][col] !== '#') return false;
            for (let i = 0; i < wordLen; i++) {
                if (board[row + i][col] !== ' ' && board[row + i][col] !== word[i]) return false;
            }
            return true;
        } else {
            if (row - wordLen + 1 < 0) return false;
            if (row + 1 < m && board[row + 1][col] !== '#') return false;
            if (row - wordLen >= 0 && board[row - wordLen][col] !== '#') return false;
            for (let i = 0; i < wordLen; i++) {
                if (board[row - i][col] !== ' ' && board[row - i][col] !== word[i]) return false;
            }
            return true;
        }
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] === ' ' || board[i][j] === word[0]) {
                if (checkHorizontal(i, j, 1) || checkVertical(i, j, 1)) {
                    return true;
                }
            }
            if (board[i][j] === ' ' || board[i][j] === word[wordLen - 1]) {
                if (checkHorizontal(i, j, -1) || checkVertical(i, j, -1)) {
                    return true;
                }
            }
        }
    }

    return false;
};