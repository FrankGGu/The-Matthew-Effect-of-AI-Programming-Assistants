var openLock = function(deadends, target) {
    const deadSet = new Set(deadends);
    if (deadSet.has('0000')) return -1;

    const queue = [['0000', 0]];
    const visited = new Set(['0000']);

    while (queue.length) {
        const [current, steps] = queue.shift();
        if (current === target) return steps;

        for (let i = 0; i < 4; i++) {
            for (let j = -1; j <= 1; j += 2) {
                const next = current.split('');
                next[i] = ((+next[i] + j + 10) % 10).toString();
                const nextLock = next.join('');

                if (!deadSet.has(nextLock) && !visited.has(nextLock)) {
                    visited.add(nextLock);
                    queue.push([nextLock, steps + 1]);
                }
            }
        }
    }

    return -1;
};