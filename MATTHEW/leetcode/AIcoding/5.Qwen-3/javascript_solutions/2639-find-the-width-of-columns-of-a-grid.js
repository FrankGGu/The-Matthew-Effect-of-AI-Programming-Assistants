function gridReport(grid) {
    if (grid.length === 0) return [];
    const result = [];
    const rows = grid.length;
    const cols = grid[0].length;

    for (let j = 0; j < cols; j++) {
        let maxWidth = 0;
        for (let i = 0; i < rows; i++) {
            maxWidth = Math.max(maxWidth, grid[i][j].length);
        }
        result.push(maxWidth);
    }

    return result;
}