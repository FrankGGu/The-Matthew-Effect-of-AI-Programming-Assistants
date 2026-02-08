var regionsBySlashes = function(grid) {
    const n = grid.length;
    const size = n * 3;
    const newGrid = Array(size).fill().map(() => Array(size).fill(0));

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === '/') {
                newGrid[i * 3][j * 3 + 2] = 1;
                newGrid[i * 3 + 1][j * 3 + 1] = 1;
                newGrid[i * 3 + 2][j * 3] = 1;
            } else if (grid[i][j] === '\\') {
                newGrid[i * 3][j * 3] = 1;
                newGrid[i * 3 + 1][j * 3 + 1] = 1;
                newGrid[i * 3 + 2][j * 3 + 2] = 1;
            }
        }
    }

    let regions = 0;
    for (let i = 0; i < size; i++) {
        for (let j = 0; j < size; j++) {
            if (newGrid[i][j] === 0) {
                regions++;
                dfs(newGrid, i, j, size);
            }
        }
    }
    return regions;
};

function dfs(grid, i, j, size) {
    if (i < 0 || j < 0 || i >= size || j >= size || grid[i][j] !== 0) {
        return;
    }
    grid[i][j] = 1;
    dfs(grid, i + 1, j, size);
    dfs(grid, i - 1, j, size);
    dfs(grid, i, j + 1, size);
    dfs(grid, i, j - 1, size);
}