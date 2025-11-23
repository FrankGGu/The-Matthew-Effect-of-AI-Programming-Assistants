var checkValidGrid = function(grid) {
    const n = grid.length;

    if (grid[0][0] !== 0) {
        return false;
    }

    const dr = [-2, -2, -1, -1, 1, 1, 2, 2];
    const dc = [-1, 1, -2, 2, -2, 2, -1, 1];

    let currentR = 0;
    let currentC = 0;

    for (let k = 0; k < n * n - 1; k++) {
        let foundNextMove = false;

        for (let i = 0; i < 8; i++) {
            const nextR = currentR + dr[i];
            const nextC = currentC + dc[i];

            if (nextR >= 0 && nextR < n && nextC >= 0 && nextC < n) {
                if (grid[nextR][nextC] === k + 1) {
                    currentR = nextR;
                    currentC = nextC;
                    foundNextMove = true;
                    break; 
                }
            }
        }

        if (!foundNextMove) {
            return false;
        }
    }

    return true;
};