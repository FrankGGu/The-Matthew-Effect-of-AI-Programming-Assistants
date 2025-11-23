function minimumJumps(forbidden, a, b, x) {
    const max = 2000 + Math.max(...forbidden) + a + b;
    const forbiddenSet = new Set(forbidden);
    const queue = [[0, 0, 0]];
    const visited = new Set();

    while (queue.length > 0) {
        const [position, jumpCount, lastJump] = queue.shift();

        if (position === x) return jumpCount;
        if (visited.has(`${position},${lastJump}`) || position < 0 || position > max || forbiddenSet.has(position)) continue;

        visited.add(`${position},${lastJump}`);

        queue.push([position + a, jumpCount + 1, 1]);
        if (lastJump === 0) {
            queue.push([position - b, jumpCount + 1, 0]);
        }
    }

    return -1;
}