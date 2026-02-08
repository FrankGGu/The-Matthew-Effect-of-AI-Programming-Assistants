function simulateRobots(robots, street) {
    const n = street.length;
    const positions = new Array(n).fill(0);
    const totalRobots = robots.length;

    for (let i = 0; i < totalRobots; i++) {
        const robot = robots[i];
        const pos = robot[0];
        const direction = robot[1];

        if (direction === 'L') {
            for (let j = pos; j >= 0; j--) {
                if (street[j] === 'X') break;
                positions[j]++;
            }
        } else {
            for (let j = pos; j < n; j++) {
                if (street[j] === 'X') break;
                positions[j]++;
            }
        }
    }

    return positions;
}