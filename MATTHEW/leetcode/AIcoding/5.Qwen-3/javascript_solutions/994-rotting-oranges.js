function orangesRotting(grid) {
    let queue = [];
    let fresh = 0;

    for (let i = 0; i < grid.length; i++) {
        for (let j = 0; j < grid[0].length; j++) {
            if (grid[i][j] === 1) {
                fresh++;
            } else if (grid[i][j] === 2) {
                queue.push([i, j]);
            }
        }
    }

    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    let time = 0;

    while (queue.length > 0 && fresh > 0) {
        let size = queue.length;

        for (let i = 0; i < size; i++) {
            let [x, y] = queue.shift();

            for (let [dx, dy] of directions) {
                let nx = x + dx;
                let ny = y + dy;

                if (nx >= 0 && ny >= 0 && nx < grid.length && ny < grid[0].length && grid[nx][ny] === 1) {
                    grid[nx][ny] = 2;
                    queue.push([nx, ny]);
                    fresh--;
                }
            }
        }

        time++;
    }

    return fresh === 0 ? time : -1;
}