function openLock(deadends, target) {
    const dead = new Set(deadends);
    const queue = [];
    const visited = new Set();

    if (dead.has("0000")) {
        return -1;
    }

    queue.push(["0000", 0]);
    visited.add("0000");

    while (queue.length > 0) {
        const [currentCombo, turns] = queue.shift();

        if (currentCombo === target) {
            return turns;
        }

        for (let i = 0; i < 4; i++) {
            const digit = parseInt(currentCombo[i]);

            // Spin up
            const upDigit = (digit + 1) % 10;
            let nextUpCombo = currentCombo.substring(0, i) + upDigit + currentCombo.substring(i + 1);

            if (!visited.has(nextUpCombo) && !dead.has(nextUpCombo)) {
                visited.add(nextUpCombo);
                queue.push([nextUpCombo, turns + 1]);
            }

            // Spin down
            const downDigit = (digit - 1 + 10) % 10;
            let nextDownCombo = currentCombo.substring(0, i) + downDigit + currentCombo.substring(i + 1);

            if (!visited.has(nextDownCombo) && !dead.has(nextDownCombo)) {
                visited.add(nextDownCombo);
                queue.push([nextDownCombo, turns + 1]);
            }
        }
    }

    return -1;
}