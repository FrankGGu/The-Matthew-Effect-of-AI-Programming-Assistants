function dominoes(board) {
    const rows = board.length;
    const cols = board[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));

    const directions = [
        [0, 1], [1, 0], [0, -1], [-1, 0]
    ];

    function isValid(r, c) {
        return r >= 0 && r < rows && c >= 0 && c < cols && board[r][c] === 0 && !visited[r][c];
    }

    function dfs(r, c) {
        visited[r][c] = true;
        for (const [dr, dc] of directions) {
            const newRow = r + dr;
            const newCol = c + dc;
            if (isValid(newRow, newCol)) {
                dfs(newRow, newCol);
            }
        }
    }

    let count = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (board[i][j] === 0 && !visited[i][j]) {
                dfs(i, j);
                count++;
            }
        }
    }

    return count;
}