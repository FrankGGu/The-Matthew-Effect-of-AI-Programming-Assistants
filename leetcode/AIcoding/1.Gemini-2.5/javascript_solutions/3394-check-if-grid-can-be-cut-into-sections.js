var canCutGrid = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const checkSection = (r1, c1, r2, c2) => {
        const val = grid[r1][c1];
        for (let i = r1; i <= r2; i++) {
            for (let j = c1; j <= c2; j++) {
                if (grid[i][j] !== val) {
                    return false;
                }
            }
        }
        return true;
    };

    for (let r = 1; r < m; r++) {
        if (checkSection(0, 0, r - 1, n - 1) && checkSection(r, 0, m - 1, n - 1)) {
            return true;
        }
    }

    for (let c = 1; c < n; c++) {
        if (checkSection(0, 0, m - 1, c - 1) && checkSection(0, c, m - 1, n - 1)) {
            return true;
        }
    }

    return false;
};