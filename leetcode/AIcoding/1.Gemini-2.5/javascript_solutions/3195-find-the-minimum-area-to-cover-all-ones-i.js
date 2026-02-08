var minimumArea = function(grid) {
    let minR = Infinity;
    let maxR = -Infinity;
    let minC = Infinity;
    let maxC = -Infinity;
    let foundOne = false;

    for (let r = 0; r < grid.length; r++) {
        for (let c = 0; c < grid[0].length; c++) {
            if (grid[r][c] === '1') {
                foundOne = true;
                minR = Math.min(minR, r);
                maxR = Math.max(maxR, r);
                minC = Math.min(minC, c);
                maxC = Math.max(maxC, c);
            }
        }
    }

    if (!foundOne) {
        return 0;
    }

    const height = maxR - minR + 1;
    const width = maxC - minC + 1;

    return height * width;
};