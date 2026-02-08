var isRobotBoundedInCircle = function(instructions) {
    let x = 0, y = 0;
    let dir = 0; // 0: north, 1: east, 2: south, 3: west
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    for (let i = 0; i < instructions.length; i++) {
        if (instructions[i] === 'G') {
            x += directions[dir][0];
            y += directions[dir][1];
        } else if (instructions[i] === 'L') {
            dir = (dir + 3) % 4;
        } else {
            dir = (dir + 1) % 4;
        }
    }

    return (x === 0 && y === 0) || dir !== 0;
};