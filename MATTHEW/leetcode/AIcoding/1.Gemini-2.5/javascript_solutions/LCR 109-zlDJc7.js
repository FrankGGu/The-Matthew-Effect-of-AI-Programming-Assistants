var openLock = function(deadends, target) {
    const deadSet = new Set(deadends);
    const start = "0000";

    if (deadSet.has(start)) {
        return -1;
    }
    if (start === target) {
        return 0;
    }

    const queue = [[start, 0]];
    const visited = new Set([start]);

    while (queue.length > 0) {
        const [currentCombination, turns] = queue.shift();

        for (let i = 0; i < 4; i++) {
            const digit = parseInt(currentCombination[i]);

            const nextDigitUp = (digit + 1) % 10;
            const nextCombinationUp = currentCombination.substring(0, i) + nextDigitUp.toString() + currentCombination.substring(i + 1);

            if (nextCombinationUp === target) {
                return turns + 1;
            }
            if (!visited.has(nextCombinationUp) && !deadSet.has(nextCombinationUp)) {
                visited.add(nextCombinationUp);
                queue.push([nextCombinationUp, turns + 1]);
            }

            const nextDigitDown = (digit - 1 + 10) % 10;
            const nextCombinationDown = currentCombination.substring(0, i) + nextDigitDown.toString() + currentCombination.substring(i + 1);

            if (nextCombinationDown === target) {
                return turns + 1;
            }
            if (!visited.has(nextCombinationDown) && !deadSet.has(nextCombinationDown)) {
                visited.add(nextCombinationDown);
                queue.push([nextCombinationDown, turns + 1]);
            }
        }
    }

    return -1;
};