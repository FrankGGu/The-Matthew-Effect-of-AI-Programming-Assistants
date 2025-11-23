var findBall = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(n).fill(-1);

    for (let col = 0; col < n; col++) {
        let currentCol = col;
        let stuck = false;

        for (let row = 0; row < m; row++) {
            const direction = grid[row][currentCol];
            const nextCol = currentCol + direction;

            if (nextCol < 0 || nextCol >= n || grid[row][nextCol] !== direction) {
                stuck = true;
                break;
            }

            currentCol = nextCol;
        }

        if (!stuck) {
            result[col] = currentCol;
        }
    }

    return result;
};