var openLock = function(deadends, target) {
    const dead = new Set(deadends);
    if (dead.has("0000")) return -1;

    const queue = ["0000"];
    const visited = new Set(["0000"]);
    let steps = 0;

    while (queue.length > 0) {
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const curr = queue.shift();
            if (curr === target) return steps;

            for (let j = 0; j < 4; j++) {
                const num = parseInt(curr[j]);
                const up = curr.substring(0, j) + ((num + 1) % 10).toString() + curr.substring(j + 1);
                const down = curr.substring(0, j) + ((num + 9) % 10).toString() + curr.substring(j + 1);

                if (!dead.has(up) && !visited.has(up)) {
                    queue.push(up);
                    visited.add(up);
                }

                if (!dead.has(down) && !visited.has(down)) {
                    queue.push(down);
                    visited.add(down);
                }
            }
        }
        steps++;
    }

    return -1;
};