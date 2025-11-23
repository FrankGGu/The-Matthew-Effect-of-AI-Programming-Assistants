var spiralMatrixIII = function(rows, cols, rStart, cStart) {
    const result = [[rStart, cStart]];
    let step = 1;
    let dir = 0; // 0: right, 1: down, 2: left, 3: up
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    while (result.length < rows * cols) {
        for (let i = 0; i < step; i++) {
            rStart += directions[dir][0];
            cStart += directions[dir][1];

            if (rStart >= 0 && rStart < rows && cStart >= 0 && cStart < cols) {
                result.push([rStart, cStart]);
            }
        }

        dir = (dir + 1) % 4;

        if (dir === 0 || dir === 2) {
            step++;
        }
    }

    return result;
};