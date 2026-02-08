var checkValidGrid = function(grid) {
    const n = grid.length;
    const moves = [
        [-2, -1], [-2, 1],
        [-1, -2], [-1, 2],
        [1, -2], [1, 2],
        [2, -1], [2, 1]
    ];
    const positions = new Array(n * n);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            positions[grid[i][j]] = [i, j];
        }
    }

    if (positions[0][0] !== 0 || positions[0][1] !== 0) {
        return false;
    }

    for (let i = 1; i < n * n; i++) {
        const [x, y] = positions[i];
        const [prevX, prevY] = positions[i - 1];
        let isValid = false;

        for (const [dx, dy] of moves) {
            if (prevX + dx === x && prevY + dy === y) {
                isValid = true;
                break;
            }
        }

        if (!isValid) {
            return false;
        }
    }

    return true;
};