function treasureIsland(grid) {
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const rows = grid.length;
    const cols = grid[0].length;
    let queue = [[0, 0]];
    let steps = 0;

    while (queue.length > 0) {
        let nextQueue = [];
        for (const [x, y] of queue) {
            if (grid[x][y] === 'X') return steps;
            grid[x][y] = 'D'; // mark as visited
            for (const [dx, dy] of directions) {
                const nx = x + dx;
                const ny = y + dy;
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && grid[nx][ny] !== 'D') {
                    nextQueue.push([nx, ny]);
                }
            }
        }
        queue = nextQueue;
        steps++;
    }
    return -1; // in case there's no treasure
}