var shortestPathBinaryMatrix = function(grid) {
    const n = grid.length;
    if (grid[0][0] === 1 || grid[n-1][n-1] === 1) return -1;

    const directions = [[-1,-1],[-1,0],[-1,1],[0,-1],[0,1],[1,-1],[1,0],[1,1]];
    const queue = [[0, 0, 1]];
    grid[0][0] = 1;

    while (queue.length > 0) {
        const [x, y, path] = queue.shift();

        if (x === n-1 && y === n-1) return path;

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < n && ny >= 0 && ny < n && grid[nx][ny] === 0) {
                grid[nx][ny] = 1;
                queue.push([nx, ny, path + 1]);
            }
        }
    }

    return -1;
};