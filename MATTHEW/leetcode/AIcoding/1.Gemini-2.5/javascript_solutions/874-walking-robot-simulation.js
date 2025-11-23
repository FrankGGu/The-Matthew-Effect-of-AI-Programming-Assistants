var robotSim = function(commands, obstacles) {
    let x = 0;
    let y = 0;
    let dir = 0; // 0: North, 1: East, 2: South, 3: West

    const dx = [0, 1, 0, -1]; // Change in x for N, E, S, W
    const dy = [1, 0, -1, 0]; // Change in y for N, E, S, W

    const obstacleSet = new Set();
    for (const obs of obstacles) {
        obstacleSet.add(`${obs[0]},${obs[1]}`);
    }

    let maxDistSq = 0;

    for (const command of commands) {
        if (command === -2) { // Turn left
            dir = (dir + 3) % 4;
        } else if (command === -1) { // Turn right
            dir = (dir + 1) % 4;
        } else { // Move forward
            for (let i = 0; i < command; i++) {
                const nextX = x + dx[dir];
                const nextY = y + dy[dir];

                if (obstacleSet.has(`${nextX},${nextY}`)) {
                    break; 
                } else {
                    x = nextX;
                    y = nextY;
                    maxDistSq = Math.max(maxDistSq, x * x + y * y);
                }
            }
        }
    }

    return maxDistSq;
};