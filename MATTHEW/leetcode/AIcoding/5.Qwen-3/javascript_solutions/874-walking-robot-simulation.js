function robotSimulate(commands, obstacles) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0;
    let dir = 0;
    let maxDistance = 0;
    const obstacleSet = new Set(obstacles.map(obstacle => `${obstacle[0]},${obstacle[1]}`));

    for (const command of commands) {
        if (command === -1) {
            dir = (dir + 1) % 4;
        } else if (command === -2) {
            dir = (dir + 3) % 4;
        } else {
            for (let i = 0; i < command; i++) {
                const nextX = x + directions[dir][0];
                const nextY = y + directions[dir][1];
                const key = `${nextX},${nextY}`;
                if (obstacleSet.has(key)) {
                    break;
                }
                x = nextX;
                y = nextY;
                maxDistance = Math.max(maxDistance, x * x + y * y);
            }
        }
    }

    return maxDistance;
}