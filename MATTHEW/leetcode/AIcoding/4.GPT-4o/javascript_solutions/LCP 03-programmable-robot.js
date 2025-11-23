var robotSim = function(commands, obstacles) {
    const direction = [[0, 1], [1, 0], [0, -1], [-1, 0]];
    let pos = [0, 0], dir = 0;
    const obstacleSet = new Set(obstacles.map(o => o.join(',')));

    for (const command of commands) {
        if (command === -2) {
            dir = (dir + 3) % 4;
        } else if (command === -1) {
            dir = (dir + 1) % 4;
        } else {
            for (let step = 0; step < command; step++) {
                const newPos = [pos[0] + direction[dir][0], pos[1] + direction[dir][1]];
                if (!obstacleSet.has(newPos.join(','))) {
                    pos = newPos;
                } else {
                    break;
                }
            }
        }
    }

    return pos[0] ** 2 + pos[1] ** 2;
};