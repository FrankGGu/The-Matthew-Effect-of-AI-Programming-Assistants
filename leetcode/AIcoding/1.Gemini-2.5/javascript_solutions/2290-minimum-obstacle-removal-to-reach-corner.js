var minimumObstacles = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    // dist[r][c] stores the minimum obstacles removed to reach (r, c)
    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));

    // Deque for 0-1 BFS. Using a JavaScript array with unshift/push/shift.
    const deque = [];

    // Starting point (0, 0)
    // The cost to reach (0, 0) is grid[0][0] (0 if empty, 1 if obstacle)
    dist[0][0] = grid[0][0];

    // If starting cell is an obstacle, it costs 1 to remove. Add to back.
    // If starting cell is empty, it costs 0. Add to front.
    // For the very first element, it doesn't strictly matter, but following the rule:
    if (grid[0][0] === 0) {
        deque.unshift([0, 0]);
    } else {
        deque.push([0, 0]);
    }

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    while (deque.length > 0) {
        // Pop from the front of the deque (lowest cost first)
        const [r, c] = deque.shift();

        // If we reached the target, we have found the minimum cost path
        // because 0-1 BFS explores in increasing order of cost.
        if (r === m - 1 && c === n - 1) {
            return dist[r][c];
        }

        for (const [dr, dc] of directions) {
            const nr = r + dr;
            const nc = c + dc;

            // Check bounds
            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                // Calculate new cost to reach (nr, nc)
                const newCost = dist[r][c] + grid[nr][nc];

                // If this path is better, update and add to deque
                if (newCost < dist[nr][nc]) {
                    dist[nr][nc] = newCost;
                    if (grid[nr][nc] === 0) {
                        // If it's an empty cell (cost 0), add to front of deque
                        deque.unshift([nr, nc]);
                    } else {
                        // If it's an obstacle (cost 1), add to back of deque
                        deque.push([nr, nc]);
                    }
                }
            }
        }
    }

    // This line should technically not be reached if a path always exists,
    // as the early return condition handles the target.
    return dist[m - 1][n - 1];
};