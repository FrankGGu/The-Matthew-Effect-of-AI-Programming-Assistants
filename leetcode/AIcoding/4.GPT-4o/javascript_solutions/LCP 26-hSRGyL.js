var navigate = function(commands) {
    let position = [0, 0];
    let direction = 0; // 0: North, 1: East, 2: South, 3: West
    const directions = [[0, 1], [1, 0], [0, -1], [-1, 0]];

    for (let command of commands) {
        if (command === 'G') {
            position[0] += directions[direction][0];
            position[1] += directions[direction][1];
        } else if (command === 'L') {
            direction = (direction + 3) % 4;
        } else if (command === 'R') {
            direction = (direction + 1) % 4;
        }
    }

    return position[0] === 0 && position[1] === 0 && direction === 0;
};