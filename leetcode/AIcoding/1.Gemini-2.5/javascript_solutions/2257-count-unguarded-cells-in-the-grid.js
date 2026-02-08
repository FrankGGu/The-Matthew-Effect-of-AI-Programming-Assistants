var countUnguardedCells = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const guarded = Array(m).fill(0).map(() => Array(n).fill(false));

    for (let r = 0; r < m; r++) {
        let hasGuard = false;
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 1) {
                hasGuard = false;
            } else if (grid[r][c] === 2) {
                hasGuard = true;
            } else {
                if (hasGuard) {
                    guarded[r][c] = true;
                }
            }
        }

        hasGuard = false;
        for (let c = n - 1; c >= 0; c--) {
            if (grid[r][c] === 1) {
                hasGuard = false;
            } else if (grid[r][c] === 2) {
                hasGuard = true;
            } else {
                if (hasGuard) {
                    guarded[r][c] = true;
                }
            }
        }
    }

    for (let c = 0; c < n; c++) {
        let hasGuard = false;
        for (let r = 0; r < m; r++) {
            if (grid[r][c] === 1) {
                hasGuard = false;
            } else if (grid[r][c] === 2) {
                hasGuard = true;
            } else {
                if (hasGuard) {
                    guarded[r][c] = true;
                }
            }
        }

        hasGuard = false;
        for (let r = m - 1; r >= 0; r--) {
            if (grid[r][c] === 1) {
                hasGuard = false;
            } else if (grid[r][c] === 2) {
                hasGuard = true;
            } else {
                if (hasGuard) {
                    guarded[r][c] = true;
                }
            }
        }
    }

    let unguardedCount = 0;
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 0 && !guarded[r][c]) {
                unguardedCount++;
            }
        }
    }

    return unguardedCount;
};