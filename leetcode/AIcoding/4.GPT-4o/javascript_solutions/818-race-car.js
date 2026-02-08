var racecar = function(target) {
    const queue = [[0, 1, 0]]; // position, speed, steps
    const visited = new Set();
    visited.add('0,1');

    while (queue.length > 0) {
        const [pos, speed, steps] = queue.shift();

        if (pos === target) return steps;

        const nextPosition = pos + speed;
        const nextSpeed = speed * 2;
        const nextState = `${nextPosition},${nextSpeed}`;

        if (Math.abs(nextPosition) < 2 * target && !visited.has(nextState)) {
            visited.add(nextState);
            queue.push([nextPosition, nextSpeed, steps + 1]);
        }

        const reverseSpeed = speed > 0 ? -1 : 1;
        const reversePosition = pos;
        const reverseState = `${reversePosition},${reverseSpeed}`;

        if (!visited.has(reverseState)) {
            visited.add(reverseState);
            queue.push([reversePosition, reverseSpeed, steps + 1]);
        }
    }

    return -1; // This line will never be reached
};