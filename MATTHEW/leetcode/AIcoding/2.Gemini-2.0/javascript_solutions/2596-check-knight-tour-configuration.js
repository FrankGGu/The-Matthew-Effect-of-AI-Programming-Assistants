var checkKnightTour = function(grid) {
    const n = grid.length;
    const m = grid[0].length;
    if (grid[0][0] !== 0) return false;

    const moves = [[-2, -1], [-2, 1], [-1, -2], [-1, 2], [1, -2], [1, 2], [2, -1], [2, 1]];

    const isValid = (x, y) => x >= 0 && x < n && y >= 0 && y < m;

    let x = 0;
    let y = 0;

    for (let i = 1; i < n * m; i++) {
        let found = false;
        for (const [dx, dy] of moves) {
            const nextX = x + dx;
            const nextY = y + dy;
            if (isValid(nextX, nextY) && grid[nextX][nextY] === i) {
                x = nextX;
                y = nextY;
                found = true;
                break;
            }
        }
        if (!found) return false;
    }

    return true;
};