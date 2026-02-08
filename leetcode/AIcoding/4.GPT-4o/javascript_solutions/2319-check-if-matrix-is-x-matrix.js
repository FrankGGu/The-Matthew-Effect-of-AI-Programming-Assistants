function checkXMatrix(grid) {
    const n = grid.length;
    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if ((i === j || i + j === n - 1) && grid[i][j] === 0) {
                return false;
            }
            if (i !== j && i + j !== n - 1 && grid[i][j] !== 0) {
                return false;
            }
        }
    }
    return true;
}