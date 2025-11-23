var robot = function(commands, obstacles) {
    // Directions: 0: East (R), 1: North (U), 2: West (L), 3: South (D)
    const dx = [1, 0, -1, 0];
    const dy = [0, 1, 0, -1];

    let currentX = 0;
    let currentY = 0;
    let currentDir = 0; // 0 for East

    // pathPoints stores the robot's position after each command in the first cycle,
    // including the initial (0,0) before any commands.
    const pathPoints = [];
    pathPoints.push([0, 0]);

    for (const command of commands) {
        if (command === 'G') {
            currentX += dx[currentDir];
            currentY += dy[currentDir];
        } else if (command === 'L') {
            currentDir = (currentDir + 1) % 4;
        } else { // command === 'R'
            currentDir = (currentDir + 3) % 4; // Equivalent to (currentDir - 1 + 4) % 4
        }
        pathPoints.push([currentX, currentY]);
    }

    // totalDx and totalDy are the net displacement after one full cycle of commands.
    const totalDx = currentX;
    const totalDy = currentY;

    const results = [];

    for (const [targetX, targetY] of obstacles) {
        let isHit = false;

        // Iterate through each point in the first cycle (including (0,0))
        for (let i = 0; i < pathPoints.length; i++) {
            const robotX_at_i = pathPoints[i][0];
            const robotY_at_i = pathPoints[i][1];

            // Calculate the remaining displacement needed to reach the target from pathPoints[i]
            const remX = targetX - robotX_at_i;
            const remY = targetY - robotY_at_i;

            let possibleCycles = -1; // -1 indicates no valid number of cycles found

            if (totalDx === 0 && totalDy === 0) {
                // Robot's path is purely periodic (returns to origin after one cycle)
                if (remX === 0 && remY === 0) {
                    possibleCycles = 0; // Target is exactly pathPoints[i]
                }
            } else if (totalDx === 0) {
                // Robot moves only vertically (totalDx is 0)
                if (remX === 0 && remY % totalDy === 0) {
                    const c = remY / totalDy;
                    if (c >= 0) {
                        possibleCycles = c;
                    }
                }
            } else if (totalDy === 0) {
                // Robot moves only horizontally (totalDy is 0)
                if (remY === 0 && remX % totalDx === 0) {
                    const c = remX / totalDx;
                    if (c >= 0) {
                        possibleCycles = c;
                    }
                }
            } else {
                // Robot moves in both X and Y directions
                if (remX % totalDx === 0 && remY % totalDy === 0) {
                    const c1 = remX / totalDx;
                    const c2 = remY / totalDy;
                    if (c1 === c2 && c1 >= 0) {
                        possibleCycles = c1;
                    }
                }
            }

            if (possibleCycles !== -1) {
                isHit = true;
                break; // Found a way to hit this obstacle, move to the next obstacle
            }
        }
        results.push(isHit);
    }

    return results;
};