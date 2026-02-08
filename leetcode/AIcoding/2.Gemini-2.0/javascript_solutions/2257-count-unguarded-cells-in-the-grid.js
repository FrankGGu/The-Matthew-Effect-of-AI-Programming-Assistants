var countUnguarded = function(m, n, guards, walls) {
    const grid = Array(m).fill(null).map(() => Array(n).fill(0));

    for (const [row, col] of walls) {
        grid[row][col] = 1; // Wall
    }

    for (const [row, col] of guards) {
        grid[row][col] = 2; // Guard
    }

    for (const [row, col] of guards) {
        // Left
        for (let c = col - 1; c >= 0; c--) {
            if (grid[row][c] === 1 || grid[row][c] === 2) break;
            grid[row][c] = 3; // Guarded
        }

        // Right
        for (let c = col + 1; c < n; c++) {
            if (grid[row][c] === 1 || grid[row][c] === 2) break;
            grid[row][c] = 3; // Guarded
        }

        // Up
        for (let r = row - 1; r >= 0; r--) {
            if (grid[r][col] === 1 || grid[r][col] === 2) break;
            grid[r][col] = 3; // Guarded
        }

        // Down
        for (let r = row + 1; r < m; r++) {
            if (grid[r][col] === 1 || grid[r][col] === 2) break;
            grid[r][col] = 3; // Guarded
        }
    }

    let unguardedCount = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                unguardedCount++;
            }
        }
    }

    return unguardedCount;
};