var countCells = function(grid) {
    if (!grid || grid.length === 0 || grid[0].length === 0) return 0;

    const rows = grid.length;
    const cols = grid[0].length;
    let count = 0;

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 'X') {
                if (isHorizontal(grid, i, j) || isVertical(grid, i, j)) {
                    count++;
                }
            }
        }
    }

    return count;
};

function isHorizontal(grid, i, j) {
    const cols = grid[0].length;
    if (j + 1 >= cols || grid[i][j + 1] !== 'X') return false;
    return true;
}

function isVertical(grid, i, j) {
    const rows = grid.length;
    if (i + 1 >= rows || grid[i + 1][j] !== 'X') return false;
    return true;
}