var findBall = function(grid) {
    const m = grid.length;
    const n = grid[0].length;
    const result = new Array(n).fill(0);

    for (let j = 0; j < n; j++) {
        let currentRow = 0;
        let currentCol = j;
        let stuck = false;

        while (currentRow < m) {
            const currentCellVal = grid[currentRow][currentCol];

            if (currentCellVal === 1) { // Ball wants to go right-down
                const nextCol = currentCol + 1;
                if (nextCol >= n || grid[currentRow][nextCol] === -1) {
                    stuck = true;
                    break;
                }
                currentCol = nextCol;
            } else { // currentCellVal === -1, Ball wants to go left-down
                const nextCol = currentCol - 1;
                if (nextCol < 0 || grid[currentRow][nextCol] === 1) {
                    stuck = true;
                    break;
                }
                currentCol = nextCol;
            }
            currentRow++;
        }

        if (stuck) {
            result[j] = -1;
        } else {
            result[j] = currentCol;
        }
    }

    return result;
};