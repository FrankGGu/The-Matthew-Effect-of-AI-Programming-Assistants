var hasPath = function(maze, start, destination) {
    const m = maze.length, n = maze[0].length;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    const queue = [start];
    const visited = new Set();
    visited.add(start.join(','));

    while (queue.length > 0) {
        const [x, y] = queue.shift();
        if (x === destination[0] && y === destination[1]) {
            return true;
        }

        for (const [dx, dy] of directions) {
            let nx = x, ny = y;
            while (nx + dx >= 0 && nx + dx < m && ny + dy >= 0 && ny + dy < n && maze[nx + dx][ny + dy] === 0) {
                nx += dx;
                ny += dy;
            }
            if (!visited.has(`${nx},${ny}`)) {
                visited.add(`${nx},${ny}`);
                queue.push([nx, ny]);
            }
        }
    }
    return false;
};