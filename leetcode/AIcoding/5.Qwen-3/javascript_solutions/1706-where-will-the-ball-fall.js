function ballSimulation(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = [];

    for (let col = 0; col < n; col++) {
        let currentCol = col;
        for (let row = 0; row < m; row++) {
            const nextCol = currentCol + grid[row][currentCol];
            if (nextCol < 0 || nextCol >= n) {
                currentCol = -1;
                break;
            }
            if (grid[row][currentCol] !== grid[row][nextCol]) {
                currentCol = -1;
                break;
            }
            currentCol = nextCol;
        }
        result.push(currentCol);
    }

    return result;
}