var robotSim = function(commands, obstacles) {
    const dir = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0, d = 0, maxDist = 0;
    const obstacleSet = new Set(obstacles.map(o => o.join(',')));

    for (let cmd of commands) {
        if (cmd === -2) {
            d = (d + 3) % 4;
        } else if (cmd === -1) {
            d = (d + 1) % 4;
        } else {
            for (let k = 0; k < cmd; k++) {
                const newX = x + dir[d][0];
                const newY = y + dir[d][1];
                if (!obstacleSet.has(newX + ',' + newY)) {
                    x = newX;
                    y = newY;
                    maxDist = Math.max(maxDist, x * x + y * y);
                } else {
                    break;
                }
            }
        }
    }

    return maxDist;
};