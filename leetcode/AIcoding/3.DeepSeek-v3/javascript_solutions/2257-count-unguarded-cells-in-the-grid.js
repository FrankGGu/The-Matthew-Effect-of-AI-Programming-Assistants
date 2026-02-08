var countUnguarded = function(m, n, guards, walls) {
    const grid = new Array(m).fill().map(() => new Array(n).fill(0));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (const [x, y] of guards) {
        grid[x][y] = 1;
    }

    for (const [x, y] of walls) {
        grid[x][y] = 2;
    }

    for (const [x, y] of guards) {
        for (const [dx, dy] of directions) {
            let nx = x + dx;
            let ny = y + dy;
            while (nx >= 0 && nx < m && ny >= 0 && ny < n && grid[nx][ny] !== 1 && grid[nx][ny] !== 2) {
                grid[nx][ny] = 3;
                nx += dx;
                ny += dy;
            }
        }
    }

    let count = 0;
    for (let i = 0; i < m; i++) {
        for (let j = 0; j < n; j++) {
            if (grid[i][j] === 0) {
                count++;
            }
        }
    }

    return count;
};