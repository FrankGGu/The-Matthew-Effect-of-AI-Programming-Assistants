var shortestPath = function(grid, k) {
    const m = grid.length;
    const n = grid[0].length;

    // If k is large enough to clear all obstacles on any shortest path,
    // the shortest path is simply m + n - 2.
    // A path from (0,0) to (m-1,n-1) has length at least m + n - 2.
    // The maximum number of obstacles on such a path is m + n - 2.
    // If k is greater than or equal to this, we can always clear them.
    if (k >= m + n - 2) {
        return m + n - 2;
    }

    const queue = [];
    // visited[r][c][remaining_k] stores whether this state has been visited.
    // The maximum k is the initial k. So the third dimension size is k + 1.
    const visited = new Array(m).fill(0).map(() => 
        new Array(n).fill(0).map(() => 
            new Array(k + 1).fill(false)
        )
    );

    // Initial state: [row, col, remaining_k, steps]
    queue.push([0, 0, k, 0]);
    visited[0][0][k] = true;

    const directions = [[-1, 0], [1, 0], [0, -1], [0, 1]]; // Up, Down, Left, Right

    let head = 0; // Manual queue head for performance (avoids costly array.shift())

    while (head < queue.length) {
        const [r, c, currentK, steps] = queue[head++];

        // If we reached the target
        if (r === m - 1 && c === n - 1) {
            return steps;
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            // Check bounds
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (grid[nr][nc] === 0) { // Empty cell
                    if (!visited[nr][nc][currentK]) {
                        visited[nr][nc][currentK] = true;
                        queue.push([nr, nc, currentK, steps + 1]);
                    }
                } else { // Obstacle cell
                    if (currentK > 0 && !visited[nr][nc][currentK - 1]) {
                        visited[nr][nc][currentK - 1] = true;
                        queue.push([nr, nc, currentK - 1, steps + 1]);
                    }
                }
            }
        }
    }

    // If target is unreachable
    return -1;
};