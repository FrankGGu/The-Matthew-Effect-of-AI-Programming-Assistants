var isRobotBounded = function(instructions) {
    let x = 0, y = 0;
    let direction = 0; // 0: north, 1: east, 2: south, 3: west

    for (let instruction of instructions) {
        if (instruction === 'G') {
            if (direction === 0) y++;
            else if (direction === 1) x++;
            else if (direction === 2) y--;
            else if (direction === 3) x--;
        } else if (instruction === 'L') {
            direction = (direction + 3) % 4;
        } else if (instruction === 'R') {
            direction = (direction + 1) % 4;
        }
    }

    return (x === 0 && y === 0) || direction !== 0;
};