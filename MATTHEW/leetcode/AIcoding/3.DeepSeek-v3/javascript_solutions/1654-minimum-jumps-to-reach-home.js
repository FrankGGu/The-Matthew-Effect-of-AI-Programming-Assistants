var minimumJumps = function(forbidden, a, b, x) {
    const maxLimit = 2000 + 2 * Math.max(a, b);
    const forbiddenSet = new Set(forbidden);
    const visited = new Set();
    const queue = [[0, 0, false]]; // [position, jumps, isBackward]
    visited.add(0 + ',' + false);

    while (queue.length > 0) {
        const [pos, jumps, isBackward] = queue.shift();

        if (pos === x) {
            return jumps;
        }

        // Jump forward
        const nextPosForward = pos + a;
        const keyForward = nextPosForward + ',' + false;
        if (nextPosForward <= maxLimit && !forbiddenSet.has(nextPosForward) && !visited.has(keyForward)) {
            visited.add(keyForward);
            queue.push([nextPosForward, jumps + 1, false]);
        }

        // Jump backward
        if (!isBackward) {
            const nextPosBackward = pos - b;
            const keyBackward = nextPosBackward + ',' + true;
            if (nextPosBackward >= 0 && !forbiddenSet.has(nextPosBackward) && !visited.has(keyBackward)) {
                visited.add(keyBackward);
                queue.push([nextPosBackward, jumps + 1, true]);
            }
        }
    }

    return -1;
};