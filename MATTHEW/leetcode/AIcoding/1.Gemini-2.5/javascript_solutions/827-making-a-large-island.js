var largestIsland = function(grid) {
    const n = grid.length;
    const m = grid[0].length;
    const islandSizes = new Map(); // Map islandId to its size
    let islandId = 2; // Start island IDs from 2 to distinguish from 0 (water) and 1 (land, unvisited)
    let maxOverallIslandSize = 0;

    const directions = [[0, 1], [0, -1], [1, 0], [-1, 0]];

    // Helper function for DFS to find and size islands
    const dfs = (r, c, currentId) => {
        const stack = [[r, c]];
        grid[r][c] = currentId;
        let currentSize = 0;

        while (stack.length > 0) {
            const [currR, currC] = stack.pop();
            currentSize++;

            for (const [dr, dc] of directions) {
                const nr = currR + dr;
                const nc = currC + dc;

                if (nr >= 0 && nr < n && nc >= 0 && nc < m && grid[nr][nc] === 1) {
                    grid[nr][nc] = currentId; // Mark as visited with current island ID
                    stack.push([nr, nc]);
                }
            }
        }
        return currentSize;
    };

    // First pass: Identify all existing islands and store their sizes
    for (let r = 0; r < n; r++) {
        for (let c = 0; c < m; c++) {
            if (grid[r][c] === 1) {
                const size = dfs(r, c, islandId);
                islandSizes.set(islandId, size);
                maxOverallIslandSize = Math.max(maxOverallIslandSize, size);
                islandId++;
            }
        }
    }

    // Second pass: Iterate through '0' cells and try flipping them
    let hasZero = false;
    for (let r = 0; r < n; r++) {
        for (let c = 0; c < m; c++) {
            if (grid[r][c] === 0) {
                hasZero = true;
                let currentPotentialSize = 1; // For the flipped '0' cell itself
                const adjacentIslandIds = new Set(); // To store unique island IDs adjacent to this '0'

                for (const [dr, dc] of directions) {
                    const nr = r + dr;
                    const nc = c + dc;

                    if (nr >= 0 && nr < n && nc >= 0 && nc < m && grid[nr][nc] > 1) {
                        // It's an existing island (ID > 1)
                        adjacentIslandIds.add(grid[nr][nc]);
                    }
                }

                for (const id of adjacentIslandIds) {
                    currentPotentialSize += islandSizes.get(id);
                }
                maxOverallIslandSize = Math.max(maxOverallIslandSize, currentPotentialSize);
            }
        }
    }

    // If there were no '0's in the grid (e.g., all 1s), maxOverallIslandSize already holds the correct answer.
    // If the grid was all '0's, maxOverallIslandSize would be 0 after the first pass,
    // and then updated to 1 in the second pass for any single '0' flip.
    // This logic covers all cases.

    // One specific edge case: if the grid is all 1s, `hasZero` will be false.
    // `maxOverallIslandSize` will be `n*m` from the first pass.
    // If the grid is all 0s, `maxOverallIslandSize` will be `0` from the first pass.
    // `hasZero` will be true. The loop will update `maxOverallIslandSize` to `1`.
    // The final return value is simply `maxOverallIslandSize`.

    return maxOverallIslandSize;
};