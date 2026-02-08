var robotCollisions = function(positions, healths, directions) {
    const n = positions.length;
    const robots = [];
    for (let i = 0; i < n; i++) {
        robots.push({
            id: i,
            pos: positions[i],
            health: healths[i],
            dir: directions[i]
        });
    }

    robots.sort((a, b) => a.pos - b.pos);

    const stack = [];

    for (const currentRobot of robots) {
        if (currentRobot.dir === 'R') {
            stack.push(currentRobot);
        } else {
            let currentRobotDestroyed = false;
            while (stack.length > 0 && stack[stack.length - 1].dir === 'R') {
                const topRobot = stack.pop();

                if (currentRobot.health > topRobot.health) {
                    currentRobot.health--;
                } else if (currentRobot.health < topRobot.health) {
                    topRobot.health--;
                    stack.push(topRobot);
                    currentRobotDestroyed = true;
                    break;
                } else {
                    currentRobotDestroyed = true;
                    break;
                }
            }
            if (!currentRobotDestroyed) {
                stack.push(currentRobot);
            }
        }
    }

    stack.sort((a, b) => a.id - b.id);
    return stack.map(robot => robot.health);
};