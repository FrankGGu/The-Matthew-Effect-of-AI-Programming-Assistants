var isRobotBounded = function(instructions) {
    let x = 0, y = 0;
    let dx = 0, dy = 1;

    for (let i = 0; i < instructions.length; i++) {
        const instruction = instructions[i];

        if (instruction === 'G') {
            x += dx;
            y += dy;
        } else if (instruction === 'L') {
            let temp = dx;
            dx = -dy;
            dy = temp;
        } else if (instruction === 'R') {
            let temp = dx;
            dx = dy;
            dy = -temp;
        }
    }

    return (x === 0 && y === 0) || (dx !== 0 || dy !== 1);
};