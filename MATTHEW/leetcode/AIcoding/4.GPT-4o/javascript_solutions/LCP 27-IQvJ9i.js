function reflect(grid) {
    const m = grid.length, n = grid[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0, dir = 0;

    while (true) {
        if (x < 0 || x >= m || y < 0 || y >= n) {
            return (x < 0 ? 1 : x >= m ? 0 : y < 0 ? 3 : 2);
        }
        if (grid[x][y] === 1) {
            dir = (dir + 1) % 4;
        }
        x += directions[dir][0];
        y += directions[dir][1];
    }
}