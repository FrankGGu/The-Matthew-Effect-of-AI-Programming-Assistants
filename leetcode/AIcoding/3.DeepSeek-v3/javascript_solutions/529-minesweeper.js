var updateBoard = function(board, click) {
    const [x, y] = click;
    if (board[x][y] === 'M') {
        board[x][y] = 'X';
        return board;
    }

    const m = board.length;
    const n = board[0].length;
    const directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];

    const dfs = (x, y) => {
        if (x < 0 || x >= m || y < 0 || y >= n || board[x][y] !== 'E') {
            return;
        }

        let mines = 0;
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (nx >= 0 && nx < m && ny >= 0 && ny < n && board[nx][ny] === 'M') {
                mines++;
            }
        }

        if (mines > 0) {
            board[x][y] = mines.toString();
        } else {
            board[x][y] = 'B';
            for (const [dx, dy] of directions) {
                dfs(x + dx, y + dy);
            }
        }
    };

    dfs(x, y);
    return board;
};