var nearestExit = function(maze, entrance) {
    const rows = maze.length;
    const cols = maze[0.length;

    const queue = [];
    queue.push([entrance[0], entrance[1], 0]); // [row, col, steps]

    const visited = Array(rows).fill(0).map(() => Array(cols).fill(false));
    visited[entrance[0]][entrance[1]] = true;

    const directions = [
        [-1, 0], // Up
        [1, 0],  // Down
        [0, -1], // Left
        [0, 1]   // Right
    ];

    while (queue.length > 0) {
        const [r, c, steps] = queue.shift();

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            // Check if new cell is within bounds
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                // Check if it's not a wall and not visited
                if (maze[nr][nc] === '.' && !visited[nr][nc]) {
                    // Check if it's an exit (on the border and not the entrance itself)
                    if ((nr === 0 || nr === rows - 1 || nc === 0 || nc === cols - 1) &&
                        !(nr === entrance[0] && nc === entrance[1])) {
                        return steps + 1;
                    }

                    visited[nr][nc] = true;
                    queue.push([nr, nc, steps + 1]);
                }
            }
        }
    }

    return -1; // No exit found
};