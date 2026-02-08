var exist = function(board, word) {
    const rows = board.length;
    const cols = board[0].length;

    function dfs(row, col, wordIndex) {
        if (wordIndex === word.length) {
            return true;
        }

        if (row < 0 || row >= rows || col < 0 || col >= cols || board[row][col] !== word[wordIndex]) {
            return false;
        }

        const temp = board[row][col];
        board[row][col] = '#'; // Mark as visited

        const found = dfs(row + 1, col, wordIndex + 1) ||
                      dfs(row - 1, col, wordIndex + 1) ||
                      dfs(row, col + 1, wordIndex + 1) ||
                      dfs(row, col - 1, wordIndex + 1);

        board[row][col] = temp; // Restore the original value
        return found;
    }

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (board[i][j] === word[0] && dfs(i, j, 0)) {
                return true;
            }
        }
    }

    return false;
};