function zigzagGridTraversal(grid) {
    const result = [];
    const rows = grid.length;
    const cols = grid[0].length;

    for (let i = 0; i < rows; i++) {
        if (i % 2 === 0) {
            for (let j = 0; j < cols; j++) {
                result.push(grid[i][j]);
            }
        } else {
            for (let j = cols - 1; j >= 0; j--) {
                result.push(grid[i][j]);
            }
        }
    }

    return result;
}