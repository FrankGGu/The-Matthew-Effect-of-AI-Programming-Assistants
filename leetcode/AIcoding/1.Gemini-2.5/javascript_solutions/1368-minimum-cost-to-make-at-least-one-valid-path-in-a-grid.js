var minCost = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    const dist = Array(m).fill(0).map(() => Array(n).fill(Infinity));

    let q0 = []; // Queue for 0-cost moves
    let q1 = []; // Queue for 1-cost moves

    // Directions: 1: right, 2: left, 3: down, 4: up
    // dx and dy arrays correspond to these directions
    const dx = [0, 0, 1, -1]; // Change in row
    const dy = [1, -1, 0, 0]; // Change in col

    dist[0][0] = 0;
    q0.push([0, 0]); // Start with (0,0) at cost 0

    let currentCost = 0;

    while (q0.length > 0 || q1.length > 0) {
        // Process all nodes reachable with currentCost
        while (q0.length > 0) {
            const [r, c] = q0.shift(); // Pop from front

            // If we've already found a cheaper path to (r,c), skip this entry.
            // This can happen if a node is added to q0 multiple times with the same cost
            // or if it was added to q0, then a better path was found, updating dist[r][c]
            if (dist[r][c] < currentCost) {
                continue;
            }

            // If we are at the target, this is the minimum cost.
            if (r === m - 1 && c === n - 1) {
                return currentCost;
            }

            // Explore all 4 possible adjacent cells
            for (let i = 0; i < 4; i++) {
                const nr = r + dx[i];
                const nc = c + dy[i];

                // Check bounds
                if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                    const preferredDirIndex = grid[r][c] - 1; // Convert 1-indexed direction to 0-indexed array index
                    let moveCost = 1; // Default cost for non-preferred moves
                    if (i === preferredDirIndex) {
                        moveCost = 0; // Cost for preferred move
                    }

                    // For 0-cost moves
                    if (moveCost === 0) {
                        if (currentCost < dist[nr][nc]) {
                            dist[nr][nc] = currentCost;
                            q0.push([nr, nc]); // Add to current layer's queue
                        }
                    } 
                    // For 1-cost moves
                    else { // moveCost === 1
                        if (currentCost + 1 < dist[nr][nc]) {
                            dist[nr][nc] = currentCost + 1;
                            q1.push([nr, nc]); // Add to next layer's queue
                        }
                    }
                }
            }
        }

        // After processing all nodes for currentCost, increment cost and move to next layer
        currentCost++;
        q0 = q1; // q0 becomes the new q1 (nodes reachable with currentCost)
        q1 = []; // q1 is reset for the next set of 1-cost moves
    }

    // This part should ideally not be reached based on the problem statement
    // "There is at least one valid path from the top-left cell to the bottom-right cell."
    return -1; 
};