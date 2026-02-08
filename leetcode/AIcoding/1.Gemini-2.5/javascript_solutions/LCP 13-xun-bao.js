var minPushBox = function(grid) {
    const m = grid.length;
    const n = grid[0].length;

    let startPlayerR, startPlayerC;
    let startBoxR, startBoxC;
    let targetR, targetC;

    for (let r = 0; r < m; r++) {
        for (let c = 0; c < n; c++) {
            if (grid[r][c] === 'S') {
                startPlayerR = r;
                startPlayerC = c;
            } else if (grid[r][c] === 'B') {
                startBoxR = r;
                startBoxC = c;
            } else if (grid[r][c] === 'T') {
                targetR = r;
                targetC = c;
            }
        }
    }

    const isValidGridPos = (r, c) => {
        return r >= 0 && r < m && c >= 0 && c < n && grid[r][c] !== '#';
    };

    const canPlayerReach = (startPR, startPC, targetPR, targetPC, boxR, boxC) => {
        if (startPR === targetPR && startPC === targetPC) return true;

        const playerQueue = [[startPR, startPC]];
        const playerVisited = new Set();
        playerVisited.add(`${startPR},${startPC}`);

        const playerDirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];

        while (playerQueue.length > 0) {
            const [currR, currC] = playerQueue.shift();

            for (const [dr, dc] of playerDirs) {
                const nr = currR + dr;
                const nc = currC + dc;

                if (isValidGridPos(nr, nc)) {
                    if (nr === boxR && nc === boxC) {
                        continue; // Player cannot move into the box's current position
                    }
                    const key = `${nr},${nc}`;
                    if (!playerVisited.has(key)) {
                        if (nr === targetPR && nc === targetPC) {
                            return true;
                        }
                        playerVisited.add(key);
                        playerQueue.push([nr, nc]);
                    }
                }
            }
        }
        return false;
    };

    // Main BFS for box pushes
    // State: [boxR, boxC, playerR, playerC, pushes]
    const queue = [[startBoxR, startBoxC, startPlayerR, startPlayerC, 0]];
    const visited = new Set();
    visited.add(`${startBoxR},${startBoxC},${startPlayerR},${startPlayerC}`);

    const boxPushDirs = [[0, 1], [0, -1], [1, 0], [-1, 0]]; // Directions for pushing the box

    while (queue.length > 0) {
        const [boxR, boxC, playerR, playerC, pushes] = queue.shift();

        if (boxR === targetR && boxC === targetC) {
            return pushes;
        }

        for (const [dr, dc] of boxPushDirs) {
            // Player needs to be at (boxR - dr, boxC - dc) to push the box in (dr, dc) direction
            const targetPlayerR = boxR - dr;
            const targetPlayerC = boxC - dc;

            // New position of the box
            const newBoxR = boxR + dr;
            const newBoxC = boxC + dc;

            // Check if the new box position is valid (within bounds and not a wall)
            if (!isValidGridPos(newBoxR, newBoxC)) {
                continue;
            }

            // Check if the player can reach the position from which to push the box
            // The player's path should not go through walls or the current box position.
            if (isValidGridPos(targetPlayerR, targetPlayerC) &&
                canPlayerReach(playerR, playerC, targetPlayerR, targetPlayerC, boxR, boxC)) {

                // Player successfully pushed the box.
                // The new player position is the old box position.
                const newPlayerR = boxR;
                const newPlayerC = boxC;

                const newStateKey = `${newBoxR},${newBoxC},${newPlayerR},${newPlayerC}`;
                if (!visited.has(newStateKey)) {
                    visited.add(newStateKey);
                    queue.push([newBoxR, newBoxC, newPlayerR, newPlayerC, pushes + 1]);
                }
            }
        }
    }

    return -1;
};