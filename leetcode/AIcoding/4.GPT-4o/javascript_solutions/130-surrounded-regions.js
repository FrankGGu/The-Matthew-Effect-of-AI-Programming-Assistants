var solve = function(board) {
    if (board.length === 0) return;

    const rows = board.length;
    const cols = board[0].length;

    const dfs = (r, c) => {
        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] !== 'O') return;
        board[r][c] = 'E';
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    };

    for (let i = 0; i < rows; i++) {
        if (board[i][0] === 'O') dfs(i, 0);
        if (board[i][cols - 1] === 'O') dfs(i, cols - 1);
    }

    for (let j = 0; j < cols; j++) {
        if (board[0][j] === 'O') dfs(0, j);
        if (board[rows - 1][j] === 'O') dfs(rows - 1, j);
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (board[i][j] === 'O') {
                board[i][j] = 'X';
            } else if (board[i][j] === 'E') {
                board[i][j] = 'O';
            }
        }
    }
};