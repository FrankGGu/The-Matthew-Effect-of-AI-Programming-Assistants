var isRobotBounded = function(instructions) {
    let x = 0, y = 0;
    let dir = 0;
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    for (let i = 0; i < instructions.length; i++) {
        const c = instructions[i];
        if (c === 'G') {
            x += directions[dir][0];
            y += directions[dir][1];
        } else if (c === 'L') {
            dir = (dir + 3) % 4;
        } else if (c === 'R') {
            dir = (dir + 1) % 4;
        }
    }

    return (x === 0 && y === 0) || dir !== 0;
};