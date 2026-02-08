var exist = function(board, word) {
    const rows = board.length;
    const cols = board[0].length;

    const dfs = (r, c, k) => {
        if (k === word.length) {
            return true;
        }

        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] !== word[k]) {
            return false;
        }

        const originalChar = board[r][c];
        board[r][c] = '#'; 

        const found = dfs(r + 1, c, k + 1) ||
                      dfs(r - 1, c, k + 1) ||
                      dfs(r, c + 1, k + 1) ||
                      dfs(r, c - 1, k + 1);

        board[r][c] = originalChar;

        return found;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (board[r][c] === word[0]) {
                if (dfs(r, c, 0)) {
                    return true;
                }
            }
        }
    }

    return false;
};