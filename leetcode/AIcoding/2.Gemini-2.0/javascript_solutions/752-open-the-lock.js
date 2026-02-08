var openLock = function(deadends, target) {
    const dead = new Set(deadends);
    if (dead.has("0000")) return -1;
    if (target === "0000") return 0;

    const queue = ["0000"];
    const visited = new Set(["0000"]);
    let moves = 0;

    while (queue.length > 0) {
        moves++;
        const size = queue.length;
        for (let i = 0; i < size; i++) {
            const current = queue.shift();

            for (let j = 0; j < 4; j++) {
                for (let k = -1; k <= 1; k += 2) {
                    let next = current.split("");
                    let digit = parseInt(next[j]);
                    digit = (digit + k + 10) % 10;
                    next[j] = digit.toString();
                    next = next.join("");

                    if (next === target) return moves;
                    if (!dead.has(next) && !visited.has(next)) {
                        queue.push(next);
                        visited.add(next);
                    }
                }
            }
        }
    }

    return -1;
};