var checkKnightTour = function(board) {
    const n = board.length;
    const directions = [
        [2, 1], [1, 2], [-1, 2], [-2, 1],
        [-2, -1], [-1, -2], [1, -2], [2, -1]
    ];

    let visited = new Set();
    let startX, startY;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (board[i][j] === 1) {
                startX = i;
                startY = j;
            }
            if (board[i][j] > 0) {
                visited.add(`${i},${j}`);
            }
        }
    }

    function isValid(x, y) {
        return x >= 0 && y >= 0 && x < n && y < n && board[x][y] > 0;
    }

    function dfs(x, y, moveCount) {
        if (moveCount === n * n) {
            return true;
        }
        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            if (isValid(nx, ny) && !visited.has(`${nx},${ny}`)) {
                visited.add(`${nx},${ny}`);
                if (dfs(nx, ny, moveCount + 1)) {
                    return true;
                }
                visited.delete(`${nx},${ny}`);
            }
        }
        return false;
    }

    visited.add(`${startX},${startY}`);
    return dfs(startX, startY, 1);
};