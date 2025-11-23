function uniquePathsIII(grid) {
    let startRow = 0, startCol = 0;
    let emptyCount = 0;

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                startRow = i;
                startCol = j;
            } else if (grid[i][j] === 0) {
                emptyCount++;
            }
        }
    }

    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let result = 0;

    function dfs(row, col, count) {
        if (grid[row][col] === 2) {
            if (count === emptyCount) {
                result++;
            }
            return;
        }

        const temp = grid[row][col];
        grid[row][col] = -1;

        for (const [dx, dy] of directions) {
            const newRow = row + dx;
            const newCol = col + dy;
            if (newRow >= 0 && newRow < grid.length && newCol >= 0 && newCol < grid[0].length && grid[newRow][newCol] !== -1) {
                dfs(newRow, newCol, count + 1);
            }
        }

        grid[row][col] = temp;
    }

    dfs(startRow, startCol, 0);
    return result;
}