function minimumMoves(grid) {
    const N = grid.length;
    const queue = [];
    // visited[r][c][orientation] stores whether the state (r, c, orientation) has been visited.
    // orientation 0: horizontal (snake occupies (r,c) and (r, c+1))
    // orientation 1: vertical (snake occupies (r,c) and (r+1, c))
    const visited = new Array(N).fill(0).map(() => new Array(N).fill(0).map(() => new Array(2).fill(false)));

    // Initial state: (row=0, col=0, orientation=0 (horizontal), moves=0)
    queue.push([0, 0, 0, 0]);
    visited[0][0][0] = true;

    while (queue.length > 0) {
        const [r, c, orientation, moves] = queue.shift();

        // Check if target is reached: snake occupies (N-1, N-2) and (N-1, N-1)
        if (r === N - 1 && c === N - 2 && orientation === 0) {
            return moves;
        }

        // Current snake is horizontal: occupies (r, c) and (r, c+1)
        if (orientation === 0) {
            // 1. Try to move right
            // New state: (r, c+1, 0)
            // Conditions: The cell (r, c+2) must be within bounds and empty.
            if (c + 2 < N && grid[r][c + 2] === 0) {
                if (!visited[r][c + 1][0]) {
                    visited[r][c + 1][0] = true;
                    queue.push([r, c + 1, 0, moves + 1]);
                }
            }

            // 2. Try to move down
            // New state: (r+1, c, 0)
            // Conditions: The cells (r+1, c) and (r+1, c+1) must be within bounds and empty.
            if (r + 1 < N && grid[r + 1][c] === 0 && grid[r + 1][c + 1] === 0) {
                if (!visited[r + 1][c][0]) {
                    visited[r + 1][c][0] = true;
                    queue.push([r + 1, c, 0, moves + 1]);
                }
            }

            // 3. Try to rotate clockwise
            // New state: (r, c, 1) (becomes vertical)
            // Conditions: The cells (r+1, c) and (r+1, c+1) must be within bounds and empty.
            if (r + 1 < N && c + 1 < N && grid[r + 1][c] === 0 && grid[r + 1][c + 1] === 0) {
                if (!visited[r][c][1]) {
                    visited[r][c][1] = true;
                    queue.push([r, c, 1, moves + 1]);
                }
            }
        } 
        // Current snake is vertical: occupies (r, c) and (r+1, c)
        else { // orientation === 1
            // 1. Try to move right
            // New state: (r, c+1, 1)
            // Conditions: The cells (r, c+1) and (r+1, c+1) must be within bounds and empty.
            if (c + 1 < N && grid[r][c + 1] === 0 && grid[r + 1][c + 1] === 0) {
                if (!visited[r][c + 1][1]) {
                    visited[r][c + 1][1] = true;
                    queue.push([r, c + 1, 1, moves + 1]);
                }
            }

            // 2. Try to move down
            // New state: (r+1, c, 1)
            // Conditions: The cell (r+2, c) must be within bounds and empty.
            if (r + 2 < N && grid[r + 2][c] === 0) {
                if (!visited[r + 1][c][1]) {
                    visited[r + 1][c][1] = true;
                    queue.push([r + 1, c, 1, moves + 1]);
                }
            }

            // 3. Try to rotate counter-clockwise
            // New state: (r, c, 0) (becomes horizontal)
            // Conditions: The cells (r, c+1) and (r+1, c+1) must be within bounds and empty.
            if (r + 1 < N && c + 1 < N && grid[r][c + 1] === 0 && grid[r + 1][c + 1] === 0) {
                if (!visited[r][c][0]) {
                    visited[r][c][0] = true;
                    queue.push([r, c, 0, moves + 1]);
                }
            }
        }
    }

    // If the queue becomes empty and the target was not reached
    return -1;
}