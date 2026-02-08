var minimumJumps = function(forbidden, a, b, x) {
    const forbiddenSet = new Set(forbidden);
    const queue = [[0, 0, false]]; // [position, steps, wentBack]
    const visited = new Set();
    visited.add('0_false');
    let maxReach = x + a + b;
    for (const f of forbidden) {
        maxReach = Math.max(maxReach, f + a + b);
    }

    while (queue.length > 0) {
        const [position, steps, wentBack] = queue.shift();

        if (position === x) {
            return steps;
        }

        const forward = position + a;
        if (forward <= maxReach && !forbiddenSet.has(forward) && !visited.has(`${forward}_false`)) {
            queue.push([forward, steps + 1, false]);
            visited.add(`${forward}_false`);
        }

        if (!wentBack) {
            const backward = position - b;
            if (backward >= 0 && !forbiddenSet.has(backward) && !visited.has(`${backward}_true`)) {
                queue.push([backward, steps + 1, true]);
                visited.add(`${backward}_true`);
            }
        }
    }

    return -1;
};