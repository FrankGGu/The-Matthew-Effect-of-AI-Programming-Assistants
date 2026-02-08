var exist = function(board, word) {
    const rows = board.length;
    const cols = board[0].length;

    function dfs(r, c, k) {
        if (k === word.length) {
            return true;
        }

        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] !== word[k]) {
            return false;
        }

        const originalChar = board[r][c];
        board[r][c] = '#'; // Mark as visited

        const found = dfs(r + 1, c, k + 1) ||
                      dfs(r - 1, c, k + 1) ||
                      dfs(r, c + 1, k + 1) ||
                      dfs(r, c - 1, k + 1);

        board[r][c] = originalChar; // Backtrack
        return found;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (board[i][j] === word[0]) {
                if (dfs(i, j, 0)) {
                    return true;
                }
            }
        }
    }

    return false;
};