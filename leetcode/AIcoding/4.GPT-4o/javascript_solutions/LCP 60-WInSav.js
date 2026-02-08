var findBall = function(grid) {
    const m = grid.length, n = grid[0].length;
    const result = new Array(n).fill(0);

    for (let j = 0; j < n; j++) {
        let col = j;
        for (let i = 0; i < m; i++) {
            if (grid[i][col] === 1) {
                if (col === n - 1 || grid[i][col + 1] === -1) {
                    col = -1;
                    break;
                }
                col++;
            } else {
                if (col === 0 || grid[i][col - 1] === 1) {
                    col = -1;
                    break;
                }
                col--;
            }
        }
        result[j] = col;
    }

    return result;
};