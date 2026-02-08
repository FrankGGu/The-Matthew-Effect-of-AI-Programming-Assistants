var robotSim = function(commands, obstacles) {
    let x = 0, y = 0;
    let dir = 0; // 0: north, 1: east, 2: south, 3: west
    const dx = [0, 1, 0, -1];
    const dy = [1, 0, -1, 0];
    let maxDistSq = 0;

    const obstacleSet = new Set();
    for (const obstacle of obstacles) {
        obstacleSet.add(obstacle[0] + ',' + obstacle[1]);
    }

    for (const command of commands) {
        if (command === -2) {
            dir = (dir + 3) % 4;
        } else if (command === -1) {
            dir = (dir + 1) % 4;
        } else {
            for (let i = 0; i < command; i++) {
                const nextX = x + dx[dir];
                const nextY = y + dy[dir];

                if (obstacleSet.has(nextX + ',' + nextY)) {
                    break;
                }

                x = nextX;
                y = nextY;
            }

            maxDistSq = Math.max(maxDistSq, x * x + y * y);
        }
    }

    return maxDistSq;
};