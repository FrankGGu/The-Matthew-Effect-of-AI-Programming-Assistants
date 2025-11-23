var canMakeSquare = function(grid) {
    for (let i = 0; i < 2; i++) {
        for (let j = 0; j < 2; j++) {
            let countB = 0, countW = 0;
            if (grid[i][j] === 'B') countB++; else countW++;
            if (grid[i][j + 1] === 'B') countB++; else countW++;
            if (grid[i + 1][j] === 'B') countB++; else countW++;
            if (grid[i + 1][j + 1] === 'B') countB++; else countW++;
            if (countB >= 3 || countW >= 3) {
                return true;
            }
        }
    }
    return false;
};