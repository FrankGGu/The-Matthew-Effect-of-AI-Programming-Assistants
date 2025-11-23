function numMagicSquaresInGrid(grid) {
    let count = 0;
    const m = grid.length;
    const n = grid[0].length;

    for (let i = 0; i <= m - 3; i++) {
        for (let j = 0; j <= n - 3; j++) {
            let set = new Set();
            let sumRow = 0, sumCol = 0, sumDiag1 = 0, sumDiag2 = 0;
            let isMagic = true;

            for (let x = 0; x < 3; x++) {
                for (let y = 0; y < 3; y++) {
                    let val = grid[i + x][j + y];
                    if (val < 1 || val > 9) isMagic = false;
                    set.add(val);
                    sumRow += grid[i + x][j + y];
                    sumCol += grid[i + y][j + x];
                    if (x === y) sumDiag1 += grid[i + x][j + y];
                    if (x + y === 2) sumDiag2 += grid[i + x][j + y];
                }
            }

            if (set.size !== 9 || isMagic === false) continue;

            if (sumRow !== sumCol || sumRow !== sumDiag1 || sumRow !== sumDiag2) continue;

            count++;
        }
    }

    return count;
}