var racecar = function(target) {
    let queue = [[0, 1]];
    let visited = new Set();
    visited.add(`0,1`);
    let steps = 0;

    while (queue.length > 0) {
        let nextQueue = [];

        for (let [pos, speed] of queue) {
            if (pos === target) {
                return steps;
            }

            // Accelerate
            let newPos = pos + speed;
            let newSpeed = speed * 2;
            let key = `${newPos},${newSpeed}`;
            if (!visited.has(key) && newPos > 0 && newPos < 2 * target) {
                visited.add(key);
                nextQueue.push([newPos, newSpeed]);
            }

            // Reverse
            newPos = pos;
            newSpeed = speed > 0 ? -1 : 1;
            key = `${newPos},${newSpeed}`;
            if (!visited.has(key) && newPos > 0 && newPos < 2 * target) {
                visited.add(key);
                nextQueue.push([newPos, newSpeed]);
            }
        }

        queue = nextQueue;
        steps++;
    }

    return -1;
};