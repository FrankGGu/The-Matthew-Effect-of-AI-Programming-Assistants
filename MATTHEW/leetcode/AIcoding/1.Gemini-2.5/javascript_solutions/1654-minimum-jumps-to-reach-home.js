var minimumJumps = function(forbidden, a, b, x) {
    const forbiddenSet = new Set(forbidden);

    const queue = [[0, 0, 0]]; 

    const visited = new Set();
    visited.add("0-0");

    const MAX_POS_LIMIT = 6000; 

    while (queue.length > 0) {
        const [currPos, wasBackward, jumps] = queue.shift();

        if (currPos === x) {
            return jumps;
        }

        const nextPosForward = currPos + a;
        const stateForward = `${nextPosForward}-0`;
        if (nextPosForward <= MAX_POS_LIMIT && !forbiddenSet.has(nextPosForward) && !visited.has(stateForward)) {
            visited.add(stateForward);
            queue.push([nextPosForward, 0, jumps + 1]);
        }

        if (wasBackward === 0) {
            const nextPosBackward = currPos - b;
            const stateBackward = `${nextPosBackward}-1`;
            if (nextPosBackward >= 0 && !forbiddenSet.has(nextPosBackward) && !visited.has(stateBackward)) {
                visited.add(stateBackward);
                queue.push([nextPosBackward, 1, jumps + 1]);
            }
        }
    }

    return -1;
};