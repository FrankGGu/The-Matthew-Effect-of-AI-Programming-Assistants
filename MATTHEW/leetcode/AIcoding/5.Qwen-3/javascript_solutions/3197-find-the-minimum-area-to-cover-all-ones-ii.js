function minimumArea(grid) {
    const rows = grid.length;
    const cols = grid[0].length;

    let top = rows, bottom = -1, left = cols, right = -1;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                top = Math.min(top, i);
                bottom = Math.max(bottom, i);
                left = Math.min(left, j);
                right = Math.max(right, j);
            }
        }
    }

    return (bottom - top + 1) * (right - left + 1);
}