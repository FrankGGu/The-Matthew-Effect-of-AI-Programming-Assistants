var solve = function(board) {
    if (!board || board.length === 0) {
        return;
    }

    const m = board.length;
    const n = board[0].length;

    function dfs(r, c) {
        if (r < 0 || r >= m || c < 0 || c >= n || board[r][c] !== 'O') {
            return;
        }
        board[r][c] = '#'; // Mark as visited and connected to border
        dfs(r + 1, c);
        dfs(r - 1, c);
        dfs(r, c + 1);
        dfs(r, c - 1);
    }

    // Traverse first and last rows
    for (let c = 0; c < n; c++) {
        if (board[0][c] === 'O') {
            dfs(0, c);
        }
        if (board[m - 1][c] === 'O') {
            dfs(m - 1, c);
        }
    }

    // Traverse first and last columns (excluding corners already covered)
    for (let r = 1; r < m - 1; r++) {
        if (board[r][0] === 'O') {
            dfs(r, 0);
        }
        if (board[r][n - 1] === 'O') {
            dfs(r, n - 1);
        }
    }

    // Final pass through the board
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (board[r][c] === 'O') {
                board[r][c] = 'X'; // Surrounded 'O's become 'X'
            } else if (board[r][c] === '#') {
                board[r][c] = 'O'; // Border-connected 'O's revert from '#' to 'O'
            }
        }
    }
};