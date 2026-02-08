var findBall = function(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    let result = new Array(cols).fill(-1);

    for (let col = 0; col < cols; col++) {
        let currentCol = col;
        for (let row = 0; row < rows; row++) {
            const direction = grid[row][currentCol];
            const nextCol = currentCol + direction;

            if (nextCol < 0 || nextCol >= cols || grid[row][currentCol] !== direction) {
                currentCol = -1;
                break;
            }
            currentCol = nextCol;
        }
        result[col] = currentCol;
    }
    return result;
};