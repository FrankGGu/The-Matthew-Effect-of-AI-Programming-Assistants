var survivedRobotsHealths = function(positions, healths, directions) {
    const stack = [];
    const n = positions.length;
    const robots = positions.map((pos, i) => ({
        pos,
        health: healths[i],
        dir: directions[i],
        index: i
    })).sort((a, b) => a.pos - b.pos);

    for (const robot of robots) {
        if (robot.dir === 'R') {
            stack.push(robot);
            continue;
        }
        while (stack.length > 0 && stack[stack.length - 1].dir === 'R') {
            const top = stack.pop();
            if (top.health > robot.health) {
                top.health -= 1;
                robot.health = 0;
                stack.push(top);
                break;
            } else if (top.health < robot.health) {
                robot.health -= 1;
                top.health = 0;
            } else {
                top.health = 0;
                robot.health = 0;
                break;
            }
        }
        if (robot.health > 0) {
            stack.push(robot);
        }
    }

    const result = new Array(n).fill(0);
    for (const robot of stack) {
        result[robot.index] = robot.health;
    }
    return result.filter(h => h > 0);
};