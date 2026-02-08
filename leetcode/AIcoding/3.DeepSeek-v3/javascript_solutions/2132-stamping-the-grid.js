var possibleToStamp = function(grid, stampHeight, stampWidth) {
    const m = grid.length;
    const n = grid[0].length;

    // Compute prefix sums for the grid
    const prefix = Array(m + 1).fill().map(() => Array(n + 1).fill(0));
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            prefix[i + 1][j + 1] = prefix[i][j + 1] + prefix[i + 1][j] - prefix[i][j] + grid[i][j];
        }
    }

    // Create a difference array to mark stamp positions
    const diff = Array(m + 2).fill().map(() => Array(n + 2).fill(0));
    for (let i = 0; i <= m - stampHeight; i++) {
        for (let j = 0; j <= n - stampWidth; j++) {
            const x = i + stampHeight;
            const y = j + stampWidth;
            const sum = prefix[x][y] - prefix[i][y] - prefix[x][j] + prefix[i][j];
            if (sum === 0) {
                diff[i + 1][j + 1]++;
                diff[i + 1][y + 1]--;
                diff[x + 1][j + 1]--;
                diff[x + 1][y + 1]++;
            }
        }
    }

    // Compute the actual stamp coverage
    const stamp = Array(m + 2).fill().map(() => Array(n + 2).fill(0));
    for (let i = 1; i <= m; i++) {
        for (let j = 1; j <= n; j++) {
            stamp[i][j] = stamp[i - 1][j] + stamp[i][j - 1] - stamp[i - 1][j - 1] + diff[i][j];
        }
    }

    // Check if all empty cells are covered by at least one stamp
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0 && stamp[i + 1][j + 1] === 0) {
                return false;
            }
        }
    }

    return true;
};