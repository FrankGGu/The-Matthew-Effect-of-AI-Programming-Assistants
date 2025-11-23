function zigzagGridTraversalWithSkip(grid) {
    const result = [];
    const rows = grid.length;
    const cols = grid[0].length;
    let row = 0, col = 0;
    let direction = 1; // 1 for right, -1 for left

    while (row < rows && col < cols) {
        result.push(grid[row][col]);
        if (direction === 1) {
            if (col + 1 < cols) {
                col++;
            } else {
                row++;
                direction = -1;
            }
        } else {
            if (col - 1 >= 0) {
                col--;
            } else {
                row++;
                direction = 1;
            }
        }
    }

    return result;
}