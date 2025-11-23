function spiralMatrixIII(rows, cols, rStart, cStart) {
    const result = [];
    let r = rStart;
    let c = cStart;
    let steps = 0;
    let direction = 0;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    while (result.length < rows * cols) {
        steps++;
        for (let i = 0; i < 2; i++) {
            const [dr, dc] = directions[direction];
            for (let j = 0; j < steps; j++) {
                if (r >= 0 && r < rows && c >= 0 && c < cols) {
                    result.push([r, c]);
                }
                r += dr;
                c += dc;
            }
            direction = (direction + 1) % 4;
        }
    }

    return result;
}