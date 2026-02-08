var canMakeSquare = function(grid) {
    for (let r = 0; r < 2; r++) {
        for (let c = 0; c < 2; c++) {
            const color1 = grid[r][c];
            const color2 = grid[r][c+1];
            const color3 = grid[r+1][c];
            const color4 = grid[r+1][c+1];

            let blackCount = 0;
            let whiteCount = 0;

            if (color1 === 'B') blackCount++; else whiteCount++;
            if (color2 === 'B') blackCount++; else whiteCount++;
            if (color3 === 'B') blackCount++; else whiteCount++;
            if (color4 === 'B') blackCount++; else whiteCount++;

            if (blackCount >= 3 || whiteCount >= 3) {
                return true;
            }
        }
    }
    return false;
};