var findBall = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = [];

    for (let ball = 0; ball < n; ball++) {
        let col = ball;
        let stuck = false;

        for (let row = 0; row < m; row++) {
            const direction = grid[row][col];
            const nextCol = col + direction;

            if (nextCol < 0 || nextCol >= n || grid[row][nextCol] !== direction) {
                stuck = true;
                break;
            }

            col = nextCol;
        }

        result.push(stuck ? -1 : col);
    }

    return result;
};