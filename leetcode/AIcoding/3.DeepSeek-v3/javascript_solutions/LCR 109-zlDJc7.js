var openLock = function(deadends, target) {
    const dead = new Set(deadends);
    const visited = new Set();
    const queue = [];
    const start = '0000';

    if (dead.has(start)) return -1;

    queue.push([start, 0]);
    visited.add(start);

    while (queue.length > 0) {
        const [current, steps] = queue.shift();

        if (current === target) return steps;

        for (let i = 0; i < 4; i++) {
            for (let delta of [-1, 1]) {
                const next = current.split('');
                next[i] = (parseInt(next[i]) + delta + 10) % 10;
                const nextStr = next.join('');

                if (!visited.has(nextStr) && !dead.has(nextStr)) {
                    visited.add(nextStr);
                    queue.push([nextStr, steps + 1]);
                }
            }
        }
    }

    return -1;
};