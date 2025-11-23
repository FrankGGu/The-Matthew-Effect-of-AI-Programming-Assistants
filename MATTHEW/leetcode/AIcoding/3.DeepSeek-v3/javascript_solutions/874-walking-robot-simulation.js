var robotSim = function(commands, obstacles) {
    const dirs = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0, dir = 0, maxDist = 0;
    const obstacleSet = new Set(obstacles.map(([x, y]) => `${x},${y}`));

    for (const cmd of commands) {
        if (cmd === -2) {
            dir = (dir + 3) % 4;
        } else if (cmd === -1) {
            dir = (dir + 1) % 4;
        } else {
            const [dx, dy] = dirs[dir];
            for (let i = 0; i < cmd; i++) {
                const nx = x + dx;
                const ny = y + dy;
                if (obstacleSet.has(`${nx},${ny}`)) {
                    break;
                }
                x = nx;
                y = ny;
                maxDist = Math.max(maxDist, x * x + y * y);
            }
        }
    }

    return maxDist;
};