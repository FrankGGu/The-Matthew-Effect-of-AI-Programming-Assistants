var hasPath = function(maze, start, destination) {
    const m = maze.length;
    const n = maze[0].length;
    const visited = new Array(m).fill().map(() => new Array(n).fill(false));
    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]];
    const queue = [start];
    visited[start[0]][start[1]] = true;

    while (queue.length > 0) {
        const [x, y] = queue.shift();
        if (x === destination[0] && y === destination[1]) {
            return true;
        }

        for (const [dx, dy] of directions) {
            let nx = x + dx;
            let ny = y + dy;

            while (nx >= 0 && nx < m && ny >= 0 && ny < n && maze[nx][ny] === 0) {
                nx += dx;
                ny += dy;
            }

            nx -= dx;
            ny -= dy;

            if (!visited[nx][ny]) {
                visited[nx][ny] = true;
                queue.push([nx, ny]);
            }
        }
    }

    return false;
};