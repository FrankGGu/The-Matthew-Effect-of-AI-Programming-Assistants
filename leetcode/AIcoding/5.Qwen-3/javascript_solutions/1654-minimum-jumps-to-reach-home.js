function minimumJumpsToHome(forbidden, a, b, n) {
    const max = Math.max(n, ...forbidden) + a + b;
    const visited = new Set();
    const queue = [[0, 0]]; // [position, steps]
    const forbiddenSet = new Set(forbidden);

    while (queue.length > 0) {
        const [pos, steps] = queue.shift();

        if (pos === n) return steps;

        const nextPos1 = pos + a;
        if (!visited.has(nextPos1) && nextPos1 <= max && !forbiddenSet.has(nextPos1)) {
            visited.add(nextPos1);
            queue.push([nextPos1, steps + 1]);
        }

        const nextPos2 = pos - b;
        if (nextPos2 >= 0 && !visited.has(nextPos2) && !forbiddenSet.has(nextPos2)) {
            visited.add(nextPos2);
            queue.push([nextPos2, steps + 1]);
        }
    }

    return -1;
}