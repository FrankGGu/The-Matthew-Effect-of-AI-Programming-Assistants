function shiftGrid(grid, k) {
    const rows = grid.length;
    const cols = grid[0].length;
    const total = rows * cols;
    const result = new Array(rows).fill(0).map(() => new Array(cols).fill(0));

    for (let i = 0; i < total; i++) {
        const newIdx = (i + k) % total;
        const oldRow = Math.floor(i / cols);
        const oldCol = i % cols;
        const newRow = Math.floor(newIdx / cols);
        const newCol = newIdx % cols;
        result[newRow][newCol] = grid[oldRow][oldCol];
    }

    return result;
}