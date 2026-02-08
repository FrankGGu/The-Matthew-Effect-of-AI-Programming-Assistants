var nearestExit = function(maze, entrance) {
    const rows = maze.length;
    const cols = maze[0].length;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const queue = [[entrance[0], entrance[1], 0]];
    maze[entrance[0]][entrance[1]] = '+';

    while (queue.length > 0) {
        const [x, y, steps] = queue.shift();

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols && maze[nx][ny] === '.') {
                if (nx === 0 || nx === rows - 1 || ny === 0 || ny === cols - 1) {
                    return steps + 1;
                }
                maze[nx][ny] = '+';
                queue.push([nx, ny, steps + 1]);
            }
        }
    }

    return -1;
};