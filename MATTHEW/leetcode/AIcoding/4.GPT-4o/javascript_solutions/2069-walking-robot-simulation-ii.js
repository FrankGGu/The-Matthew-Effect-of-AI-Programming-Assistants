var robotSim = function(commands, obstacles) {
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let x = 0, y = 0, d = 0, maxDist = 0;
    const obstacleSet = new Set(obstacles.map(ob => ob.join(',')));

    for (let command of commands) {
        if (command === -2) {
            d = (d + 3) % 4;
        } else if (command === -1) {
            d = (d + 1) % 4;
        } else {
            for (let i = 0; i < command; i++) {
                const newX = x + directions[d][0];
                const newY = y + directions[d][1];
                if (!obstacleSet.has(`${newX},${newY}`)) {
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