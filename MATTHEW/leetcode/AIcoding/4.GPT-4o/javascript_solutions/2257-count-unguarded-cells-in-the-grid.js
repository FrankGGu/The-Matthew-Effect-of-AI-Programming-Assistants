function countUnguarded(m, n, guards, walls) {
    const grid = Array.from({ length: m }, () => Array(n).fill(0));

    for (const [x, y] of walls) {
        grid[x][y] = -1;
    }

    for (const [x, y] of guards) {
        grid[x][y] = 1;

        for (let i = x + 1; i < m && grid[i][y] !== -1; i++) {
            grid[i][y] = 2;
        }
        for (let i = x - 1; i >= 0 && grid[i][y] !== -1; i--) {
            grid[i][y] = 2;
        }
        for (let j = y + 1; j < n && grid[x][j] !== -1; j++) {
            grid[x][j] = 2;
        }
        for (let j = y - 1; j >= 0 && grid[x][j] !== -1; j--) {
            grid[x][j] = 2;
        }
    }

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                count++;
            }
        }
    }

    return count;
}