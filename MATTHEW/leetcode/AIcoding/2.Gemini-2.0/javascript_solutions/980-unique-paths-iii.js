var uniquePathsIII = function(grid) {
    let startRow, startCol, emptySquares = 0;
    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                startRow = i;
                startCol = j;
            } else if (grid[i][j] === 0) {
                emptySquares++;
            }
        }
    }

    let paths = 0;
    const rows = grid.length;
    const cols = grid[0].length;

    function backtrack(row, col, visited) {
        if (row < 0 || row >= rows || col < 0 || col >= cols || grid[row][col] === -1) {
            return;
        }

        if (grid[row][col] === 2) {
            if (visited === emptySquares + 1) {
                paths++;
            }
            return;
        }

        grid[row][col] = -1;

        backtrack(row + 1, col, visited + 1);
        backtrack(row - 1, col, visited + 1);
        backtrack(row, col + 1, visited + 1);
        backtrack(row, col - 1, visited + 1);

        grid[row][col] = 0;
    }

    backtrack(startRow, startCol, 0);
    return paths;
};