var updateBoard = function(board, click) {
    const m = board.length;
    const n = board[0].length;
    const row = click[0];
    const col = click[1];

    if (board[row][col] === 'M') {
        board[row][col] = 'X';
        return board;
    }

    function reveal(r, c) {
        if (r < 0 || r >= m || c < 0 || c >= n || board[r][c] !== 'E') {
            return;
        }

        let count = 0;
        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                if (i === 0 && j === 0) continue;
                const nr = r + i;
                const nc = c + j;
                if (nr >= 0 && nr < m && nc >= 0 && nc < n && board[nr][nc] === 'M') {
                    count++;
                }
            }
        }

        if (count > 0) {
            board[r][c] = count.toString();
        } else {
            board[r][c] = 'B';
            for (let i = -1; i <= 1; i++) {
                for (let j = -1; j <= 1; j++) {
                    if (i === 0 && j === 0) continue;
                    reveal(r + i, c + j);
                }
            }
        }
    }

    reveal(row, col);
    return board;
};