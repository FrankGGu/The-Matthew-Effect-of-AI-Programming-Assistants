var survivedRobotsHealths = function(positions, directions, healths) {
    const n = positions.length;
    const robots = [];
    for (let i = 0; i < n; i++) {
        robots.push({ pos: positions[i], dir: directions[i], health: healths[i], index: i });
    }

    robots.sort((a, b) => a.pos - b.pos);

    const stack = [];
    for (let robot of robots) {
        if (robot.dir === 'R') {
            stack.push(robot);
        } else {
            while (stack.length > 0 && robot.health > 0) {
                const top = stack[stack.length - 1];
                if (top.dir === 'R') {
                    if (top.health > robot.health) {
                        top.health--;
                        robot.health = 0;
                    } else if (top.health < robot.health) {
                        robot.health--;
                        stack.pop();
                    } else {
                        robot.health = 0;
                        stack.pop();
                    }
                } else {
                    break;
                }
            }
            if (robot.health > 0) {
                stack.push(robot);
            }
        }
    }

    const survived = [];
    for (let robot of stack) {
        survived.push(robot.index);
    }

    survived.sort((a, b) => a - b);
    const result = [];
    for (let index of survived) {
        result.push(healths[index]);
    }
    return result;
};