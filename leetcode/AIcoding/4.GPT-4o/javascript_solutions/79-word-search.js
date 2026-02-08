var exist = function(board, word) {
    const rows = board.length;
    const cols = board[0].length;

    const dfs = (r, c, index) => {
        if (index === word.length) return true;
        if (r < 0 || r >= rows || c < 0 || c >= cols || board[r][c] !== word[index]) return false;

        const temp = board[r][c];
        board[r][c] = '#'; // mark as visited

        const found = dfs(r + 1, c, index + 1) || 
                      dfs(r - 1, c, index + 1) || 
                      dfs(r, c + 1, index + 1) || 
                      dfs(r, c - 1, index + 1);

        board[r][c] = temp; // unmark
        return found;
    };

    for (let r = 0; r < rows; r++) {
        for (let c = 0; c < cols; c++) {
            if (dfs(r, c, 0)) return true;
        }
    }

    return false;
};