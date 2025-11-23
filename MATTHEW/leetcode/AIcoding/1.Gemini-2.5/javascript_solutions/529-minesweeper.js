var updateBoard = function(board, click) {
    const m = board.length;
    const n = board[0].length;
    const [r, c] = click;

    if (board[r][c] === 'M') {
        board[r][c] = 'X';
        return board;
    }

    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],           [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    function dfs(row, col) {
        if (row < 0 || row >= m || col < 0 || col >= n || board[row][col] !== 'E') {
            return;
        }

        let mineCount = 0;
        for (const [dr, dc] of directions) {
            const nr = row + dr;
            const nc = col + dc;
            if (nr >= 0 && nr < m && nc >= 0 && nc < n && board[nr][nc] === 'M') {
                mineCount++;
            }
        }

        if (mineCount > 0) {
            board[row][col] = String(mineCount);
        } else {
            board[row][col] = 'B';
            for (const [dr, dc] of directions) {
                const nr = row + dr;
                const nc = col + dc;
                dfs(nr, nc);
            }
        }
    }

    dfs(r, c);

    return board;
};