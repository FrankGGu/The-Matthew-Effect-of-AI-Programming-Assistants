var openLock = function(deadends, target) {
    const dead = new Set(deadends);
    const visited = new Set();
    const queue = [];
    const start = '0000';

    if (dead.has(start)) return -1;
    if (start === target) return 0;

    queue.push([start, 0]);
    visited.add(start);

    while (queue.length > 0) {
        const [current, turns] = queue.shift();

        for (let i = 0; i < 4; i++) {
            for (let delta of [-1, 1]) {
                const next = current.split('');
                next[i] = String((parseInt(next[i]) + delta + 10) % 10);
                const nextStr = next.join('');

                if (nextStr === target) return turns + 1;
                if (!dead.has(nextStr) && !visited.has(nextStr)) {
                    visited.add(nextStr);
                    queue.push([nextStr, turns + 1]);
                }
            }
        }
    }

    return -1;
};