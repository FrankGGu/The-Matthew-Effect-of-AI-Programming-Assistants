function openLock(deadends, target) {
    const dead = new Set(deadends);
    if (dead.has("0000")) return -1;
    const queue = ["0000"];
    const visited = new Set(["0000"]);
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();
            if (current === target) return steps;
            for (let j = 0; j < 4; j++) {
                for (let k = -1; k <= 1; k += 2) {
                    const next = current.slice(0, j) + ((parseInt(current[j]) + k + 10) % 10) + current.slice(j + 1);
                    if (!visited.has(next) && !dead.has(next)) {
                        visited.add(next);
                        queue.push(next);
                    }
                }
            }
        }
        steps++;
    }

    return -1;
}