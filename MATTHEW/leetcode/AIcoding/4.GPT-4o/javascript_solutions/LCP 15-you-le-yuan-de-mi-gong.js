var canReach = function(maze, start, destination) {
    const rows = maze.length;
    const cols = maze[0].length;
    const visited = new Set();
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const isInBounds = (x, y) => x >= 0 && x < rows && y >= 0 && y < cols;

    const dfs = (x, y) => {
        if (!isInBounds(x, y) || visited.has(`${x},${y}`) || maze[x][y] === 1) return false;
        if (x === destination[0] && y === destination[1]) return true;

        visited.add(`${x},${y}`);

        for (const [dx, dy] of directions) {
            let nx = x, ny = y;
            while (isInBounds(nx + dx, ny + dy) && maze[nx + dx][ny + dy] === 0) {
                nx += dx;
                ny += dy;
            }
            if (dfs(nx, ny)) return true;
        }

        return false;
    };

    return dfs(start[0], start[1]);
};