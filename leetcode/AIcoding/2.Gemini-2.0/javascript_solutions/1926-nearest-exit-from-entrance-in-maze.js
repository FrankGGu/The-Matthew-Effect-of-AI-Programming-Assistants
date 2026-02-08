var nearestExit = function(maze, entrance) {
    const m = maze.length;
    const n = maze[0].length;
    const queue = [[entrance[0], entrance[1], 0]];
    const visited = new Set();
    visited.add(entrance[0] + "," + entrance[1]);

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (queue.length > 0) {
        const [row, col, steps] = queue.shift();

        for (const [dr, dc] of directions) {
            const newRow = row + dr;
            const newCol = col + dc;

            if (newRow >= 0 && newRow < m && newCol >= 0 && newCol < n && maze[newRow][newCol] === '.' && !visited.has(newRow + "," + newCol)) {
                if (newRow === 0 || newRow === m - 1 || newCol === 0 || newCol === n - 1) {
                    return steps + 1;
                }
                queue.push([newRow, newCol, steps + 1]);
                visited.add(newRow + "," + newCol);
            }
        }
    }

    return -1;
};