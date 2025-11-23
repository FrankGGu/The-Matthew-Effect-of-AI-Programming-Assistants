function findTargetInGrid(grid) {
    const rows = grid.length;
    const cols = grid[0].length;
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (grid[i][j] === 1) {
                let count = 1;
                for (const [dx, dy] of directions) {
                    let x = i + dx;
                    let y = j + dy;
                    while (x >= 0 && x < rows && y >= 0 && y < cols && grid[x][y] === 1) {
                        count++;
                        x += dx;
                        y += dy;
                    }
                }
                return count;
            }
        }
    }
    return 0;
}