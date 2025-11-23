var openLock = function(deadends, target) {
    const deadSet = new Set(deadends);
    if (deadSet.has("0000")) return -1;

    const queue = ["0000"];
    const visited = new Set();
    visited.add("0000");
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current === target) return steps;

            for (let j = 0; j < 4; j++) {
                for (let k = -1; k <= 1; k += 2) {
                    const next = current.split('');
                    next[j] = ((+next[j] + k + 10) % 10).toString();
                    const nextLock = next.join('');
                    if (!deadSet.has(nextLock) && !visited.has(nextLock)) {
                        visited.add(nextLock);
                        queue.push(nextLock);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
};