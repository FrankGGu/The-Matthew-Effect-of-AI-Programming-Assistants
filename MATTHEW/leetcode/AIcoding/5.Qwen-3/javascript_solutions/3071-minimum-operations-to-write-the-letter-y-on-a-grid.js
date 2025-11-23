function minimumOperationsToWriteY(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const yPositions = new Set();
    const centerRow = Math.floor(rows / 2);
    const centerCol = Math.floor(cols / 2);

    for (let i = 0; i <= centerRow; i++) {
        yPositions.add(`${i},${0}`);
        yPositions.add(`${i},${cols - 1}`);
        yPositions.add(`${i},${Math.abs(i - centerRow) + 0}`);
        yPositions.add(`${i},${cols - 1 - Math.abs(i - centerRow)}`);
    }

    for (let j = 1; j < centerCol; j++) {
        yPositions.add(`${centerRow},${j}`);
    }

    const count = {};
    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (yPositions.has(`${i},${j}`)) {
                const c = grid[i][j];
                count[c] = (count[c] || 0) + 1;
            }
        }
    }

    const total = rows * cols;
    const yLength = yPositions.size;
    const yChars = Object.keys(count).map(c => [c, count[c]]);
    yChars.sort((a, b) => b[1] - a[1]);

    let operations = 0;
    let used = 0;

    for (const [c, freq] of yChars) {
        if (used + freq <= yLength) {
            used += freq;
        } else {
            operations += (yLength - used);
            break;
        }
    }

    return operations;
}