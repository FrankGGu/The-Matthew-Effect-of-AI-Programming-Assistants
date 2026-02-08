var findBall = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = [];

    for (let i = 0; i < n; i++) {
        let col = i;
        let row = 0;
        while (row < m) {
            const direction = grid[row][col];
            if (direction === 1) {
                if (col === n - 1 || grid[row][col + 1] === -1) {
                    col = -1;
                    break;
                } else {
                    col++;
                }
            } else {
                if (col === 0 || grid[row][col - 1] === 1) {
                    col = -1;
                    break;
                } else {
                    col--;
                }
            }
            row++;
        }
        result.push(col);
    }

    return result;
};