var spiralMatrixIII = function(rows, cols, rStart, cStart) {
    const result = [];
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let dir = 0;
    let step = 1;
    let stepsTaken = 0;
    let x = rStart;
    let y = cStart;
    result.push([x, y]);

    while (result.length < rows * cols) {
        for (let i = 0; i < step; i++) {
            x += directions[dir][0];
            y += directions[dir][1];
            if (x >= 0 && x < rows && y >= 0 && y < cols) {
                result.push([x, y]);
            }
        }
        dir = (dir + 1) % 4;
        stepsTaken++;
        if (stepsTaken % 2 === 0) {
            step++;
        }
    }

    return result;
};