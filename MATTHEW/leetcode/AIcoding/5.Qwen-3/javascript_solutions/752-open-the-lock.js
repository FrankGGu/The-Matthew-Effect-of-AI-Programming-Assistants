function openLock(deadends, target) {
    const dead = new Set(deadends);
    const visited = new Set();
    const queue = [];

    const start = "0000";
    if (dead.has(start)) return -1;

    queue.push([start, 0]);
    visited.add(start);

    const directions = [
        [1, 0, 0, 0], [-1, 0, 0, 0],
        [0, 1, 0, 0], [0, -1, 0, 0],
        [0, 0, 1, 0], [0, 0, -1, 0],
        [0, 0, 0, 1], [0, 0, 0, -1]
    ];

    while (queue.length > 0) {
        const [current, steps] = queue.shift();

        if (current === target) return steps;

        for (const dir of directions) {
            let next = "";
            for (let i = 0; i < 4; i++) {
                let digit = parseInt(current[i]) + dir[i];
                if (digit < 0) digit = 9;
                if (digit > 9) digit = 0;
                next += digit.toString();
            }

            if (!visited.has(next) && !dead.has(next)) {
                visited.add(next);
                queue.push([next, steps + 1]);
            }
        }
    }

    return -1;
}