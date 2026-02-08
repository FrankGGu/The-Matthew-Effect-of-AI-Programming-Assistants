var updateBoard = function(board, click) {
    const directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 1], [1, -1], [1, 0], [1, 1]];
    const [x, y] = click;

    if (board[x][y] === 'M') {
        board[x][y] = 'X';
        return board;
    }

    const inBounds = (x, y) => x >= 0 && x < board.length && y >= 0 && y < board[0].length;
    const countMines = (x, y) => {
        let count = 0;
        for (const [dx, dy] of directions) {
            const nx = x + dx, ny = y + dy;
            if (inBounds(nx, ny) && board[nx][ny] === 'M') count++;
        }
        return count;
    };

    const dfs = (x, y) => {
        if (!inBounds(x, y) || board[x][y] !== 'E') return;
        const mines = countMines(x, y);
        if (mines > 0) {
            board[x][y] = mines.toString();
            return;
        }
        board[x][y] = 'B';
        for (const [dx, dy] of directions) {
            dfs(x + dx, y + dy);
        }
    };

    dfs(x, y);
    return board;
};