function canCutGrid(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    const checkSection = (r1, c1, r2, c2) => {
        const color = grid[r1][c1];
        for (let r = r1; r <= r2; r++) {
            for (let c = c1; c <= c2; c++) {
                if (grid[r][c] !== color) return false;
            }
        }
        return true;
    };

    for (let r = 0; r < rows - 1; r++) {
        if (grid[r][0] !== grid[r + 1][0]) {
            if (!checkSection(r, 0, r + 1, cols - 1)) return false;
        }
    }

    for (let c = 0; c < cols - 1; c++) {
        if (grid[0][c] !== grid[0][c + 1]) {
            if (!checkSection(0, c, rows - 1, c + 1)) return false;
        }
    }

    return true;
}