var canEscape = function(maze, start, destination) {
    const rows = maze.length;
    const cols = maze[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];

    const isValid = (x, y) => x >= 0 && x < rows && y >= 0 && y < cols && maze[x][y] === 0;

    const dfs = (x, y) => {
        if (visited[x][y]) return;
        visited[x][y] = true;
        for (const [dx, dy] of directions) {
            let nx = x, ny = y;
            while (isValid(nx + dx, ny + dy)) {
                nx += dx;
                ny += dy;
            }
            if (!visited[nx][ny]) dfs(nx, ny);
        }
    };

    dfs(start[0], start[1]);
    return visited[destination[0]][destination[1]];
};