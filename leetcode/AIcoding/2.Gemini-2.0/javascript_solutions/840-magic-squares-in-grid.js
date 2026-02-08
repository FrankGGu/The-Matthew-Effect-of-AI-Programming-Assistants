var numMagicSquaresInside = function(grid) {
    let count = 0;
    for (let i = 0; i <= grid.length - 3; i++) {
        for (let j = 0; j <= grid[0].length - 3; j++) {
            if (isMagicSquare(grid, i, j)) {
                count++;
            }
        }
    }
    return count;

    function isMagicSquare(grid, row, col) {
        let nums = new Set();
        for (let i = row; i < row + 3; i++) {
            for (let j = col; j < col + 3; j++) {
                let num = grid[i][j];
                if (num < 1 || num > 9 || nums.has(num)) {
                    return false;
                }
                nums.add(num);
            }
        }

        let sum = grid[row][col] + grid[row][col + 1] + grid[row][col + 2];

        for (let i = row; i < row + 3; i++) {
            let rowSum = 0;
            for (let j = col; j < col + 3; j++) {
                rowSum += grid[i][j];
            }
            if (rowSum !== sum) {
                return false;
            }
        }

        for (let j = col; j < col + 3; j++) {
            let colSum = 0;
            for (let i = row; i < row + 3; i++) {
                colSum += grid[i][j];
            }
            if (colSum !== sum) {
                return false;
            }
        }

        let diag1 = grid[row][col] + grid[row + 1][col + 1] + grid[row + 2][col + 2];
        let diag2 = grid[row][col + 2] + grid[row + 1][col + 1] + grid[row + 2][col];

        if (diag1 !== sum || diag2 !== sum) {
            return false;
        }

        return true;
    }
};