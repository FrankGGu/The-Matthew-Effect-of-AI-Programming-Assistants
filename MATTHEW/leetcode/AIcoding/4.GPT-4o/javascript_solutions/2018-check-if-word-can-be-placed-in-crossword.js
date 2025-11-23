var placeWordInCrossword = function(board, word) {
    const n = board.length, m = board[0].length;

    const canPlace = (r, c, dr, dc) => {
        for (let i = 0; i < word.length; i++) {
            const nr = r + dr * i, nc = c + dc * i;
            if (nr < 0 || nr >= n || nc < 0 || nc >= m) return false;
            if (board[nr][nc] !== ' ' && board[nr][nc] !== word[i]) return false;
        }
        return true;
    };

    const place = (r, c, dr, dc) => {
        for (let i = 0; i < word.length; i++) {
            const nr = r + dr * i, nc = c + dc * i;
            board[nr][nc] = word[i];
        }
    };

    const remove = (r, c, dr, dc) => {
        for (let i = 0; i < word.length; i++) {
            const nr = r + dr * i, nc = c + dc * i;
            board[nr][nc] = ' ';
        }
    };

    for (let r = 0; r < n; r++) {
        for (let c = 0; c < m; c++) {
            if (board[r][c] === ' ') {
                if (c === 0 || board[r][c - 1] === '#') {
                    if (canPlace(r, c, 0, 1)) {
                        place(r, c, 0, 1);
                        if (check()) return true;
                        remove(r, c, 0, 1);
                    }
                }
                if (r === 0 || board[r - 1][c] === '#') {
                    if (canPlace(r, c, 1, 0)) {
                        place(r, c, 1, 0);
                        if (check()) return true;
                        remove(r, c, 1, 0);
                    }
                }
            }
        }
    }

    const check = () => {
        for (let r = 0; r < n; r++) {
            let count = 0;
            for (let c = 0; c < m; c++) {
                if (board[r][c] === '#') {
                    if (count > 0 && count !== word.length) return false;
                    count = 0;
                } else {
                    count++;
                }
            }
            if (count > 0 && count !== word.length) return false;
        }
        for (let c = 0; c < m; c++) {
            let count = 0;
            for (let r = 0; r < n; r++) {
                if (board[r][c] === '#') {
                    if (count > 0 && count !== word.length) return false;
                    count = 0;
                } else {
                    count++;
                }
            }
            if (count > 0 && count !== word.length) return false;
        }
        return true;
    };

    return false;
};