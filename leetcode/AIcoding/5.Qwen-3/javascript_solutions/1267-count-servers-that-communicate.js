function countServers(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const rowCounts = new Array(rows).fill(0);
    const colCounts = new Array(cols).fill(0);

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                rowCounts[i]++;
                colCounts[j]++;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1 && (rowCounts[i] > 1 || colCounts[j] > 1)) {
                count++;
            }
        }
    }

    return count;
}