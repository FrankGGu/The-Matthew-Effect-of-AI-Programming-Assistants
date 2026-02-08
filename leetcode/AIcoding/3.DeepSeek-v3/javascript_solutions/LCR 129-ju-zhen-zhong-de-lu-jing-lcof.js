var exist = function(board, word) {
    const m = board.length;
    const n = board[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    const dfs = (i, j, index) => {
        if (index === word.length) return true;
        if (i < 0 || i >= m || j < 0 || j >= n || board[i][j] !== word[index]) return false;

        const temp = board[i][j];
        board[i][j] = '#';

        for (const [dx, dy] of directions) {
            const x = i + dx;
            const y = j + dy;
            if (dfs(x, y, index + 1)) {
                board[i][j] = temp;
                return true;
            }
        }

        board[i][j] = temp;
        return false;
    };

    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (dfs(i, j, 0)) return true;
        }
    }

    return false;
};