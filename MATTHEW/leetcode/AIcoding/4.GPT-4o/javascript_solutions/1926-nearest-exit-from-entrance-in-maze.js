var nearestExit = function(maze, entrance) {
    const rows = maze.length;
    const cols = maze[0].length;
    const directions = [[1, 0], [-1, 0], [0, 1], [0, -1]];
    const queue = [[entrance[0], entrance[1], 0]];
    const visited = new Set();
    visited.add(entrance.join(','));

    while (queue.length > 0) {
        const [x, y, steps] = queue.shift();

        for (const [dx, dy] of directions) {
            const newX = x + dx;
            const newY = y + dy;

            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && maze[newX][newY] === '.' && !visited.has(`${newX},${newY}`)) {
                if (newX !== entrance[0] || newY !== entrance[1] && (newX === 0 || newX === rows - 1 || newY === 0 || newY === cols - 1)) {
                    return steps + 1;
                }
                visited.add(`${newX},${newY}`);
                queue.push([newX, newY, steps + 1]);
            }
        }
    }
    return -1;
};