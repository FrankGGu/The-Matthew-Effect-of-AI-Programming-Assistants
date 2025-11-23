function hasPath(maze, start, destination) {
    const rows = maze.length;
    const cols = maze[0].length;
    const visited = Array.from({ length: rows }, () => Array(cols).fill(false));
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    function dfs(x, y) {
        if (visited[x][y]) return false;
        if (x === destination[0] && y === destination[1]) return true;

        visited[x][y] = true;

        for (const [dx, dy] of directions) {
            let nx = x + dx;
            let ny = y + dy;

            while (nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] === 0) {
                nx += dx;
                ny += dy;
            }

            nx -= dx;
            ny -= dy;

            if (dfs(nx, ny)) {
                return true;
            }
        }

        return false;
    }

    return dfs(start[0], start[1]);
}