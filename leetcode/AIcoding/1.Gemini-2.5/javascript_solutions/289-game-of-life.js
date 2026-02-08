var gameOfLife = function(board) {
    const m = board.length;
    const n = board[0].length;

    // Directions for 8 neighbors
    const directions = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1],           [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    // First pass: Update board with intermediate states
    // 0: dead
    // 1: live
    // 2: live -> dead (was 1, will become 0)
    // 3: dead -> live (was 0, will become 1)
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            let liveNeighbors = 0;

            for (const [dr, dc] of directions) {
                const nr = r + dr;
                const nc = c + dc;

                // Check bounds
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    // A neighbor is considered "live" if its current state is 1 or 2 (was 1)
                    if (board[nr][nc] === 1 || board[nr][nc] === 2) {
                        liveNeighbors++;
                    }
                }
            }

            // Apply Game of Life rules
            if (board[r][c] === 1) { // Current cell is live
                if (liveNeighbors < 2 || liveNeighbors > 3) {
                    board[r][c] = 2; // Mark as live -> dead
                }
                // If liveNeighbors is 2 or 3, it stays live (value remains 1)
            } else { // Current cell is dead (board[r][c] === 0)
                if (liveNeighbors === 3) {
                    board[r][c] = 3; // Mark as dead -> live
                }
                // If liveNeighbors is not 3, it stays dead (value remains 0)
            }
        }
    }

    // Second pass: Convert intermediate states to final states
    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (board[r][c] === 2) {
                board[r][c] = 0; // Live -> dead becomes 0
            } else if (board[r][c] === 3) {
                board[r][c] = 1; // Dead -> live becomes 1
            }
        }
    }
};