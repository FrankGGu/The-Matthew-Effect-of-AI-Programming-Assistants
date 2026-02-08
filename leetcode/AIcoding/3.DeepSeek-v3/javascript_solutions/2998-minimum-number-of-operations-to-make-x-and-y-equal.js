var minimumOperationsToMakeEqual = function(x, y) {
    if (x === y) return 0;

    let queue = [[x, 0]];
    let visited = new Set();
    visited.add(x);

    while (queue.length > 0) {
        let [current, steps] = queue.shift();

        if (current === y) {
            return steps;
        }

        let next;

        // Option 1: Increment by 1
        next = current + 1;
        if (!visited.has(next) && next <= 10000) {
            visited.add(next);
            queue.push([next, steps + 1]);
        }

        // Option 2: Decrement by 1
        next = current - 1;
        if (!visited.has(next) && next >= 0) {
            visited.add(next);
            queue.push([next, steps + 1]);
        }

        // Option 3: Divide by 5 if divisible
        if (current % 5 === 0) {
            next = current / 5;
            if (!visited.has(next)) {
                visited.add(next);
                queue.push([next, steps + 1]);
            }
        }

        // Option 4: Divide by 11 if divisible
        if (current % 11 === 0) {
            next = current / 11;
            if (!visited.has(next)) {
                visited.add(next);
                queue.push([next, steps + 1]);
            }
        }
    }

    return -1;
};