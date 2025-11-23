var minimumMoves = function (grid) {
    const n = grid.length;
    let stones = 0;
    let moves = 0;

    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const visited = new Set();

    const dfs = (x, y) => {
        if (x < 0 || x >= n || y < 0 || y >= n || grid[x][y] === 0 || visited.has(`${x},${y}`)) {
            return;
        }
        visited.add(`${x},${y}`);
        stones++;
        for (const [dx, dy] of directions) {
            dfs(x + dx, y + dy);
        }
    };

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 1) {
                dfs(i, j);
                moves++;
            }
        }
    }

    return moves + Math.max(0, stones - n * n);
};