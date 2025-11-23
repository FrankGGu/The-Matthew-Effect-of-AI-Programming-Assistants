var minJumps = function(arr) {
    if (arr.length <= 1) return 0;

    const valueIndices = new Map();
    for (let i = 0; i < arr.length; i++) {
        if (!valueIndices.has(arr[i])) {
            valueIndices.set(arr[i], []);
        }
        valueIndices.get(arr[i]).push(i);
    }

    const visited = new Set();
    const queue = [[0, 0]];
    visited.add(0);

    while (queue.length > 0) {
        const [currentIndex, steps] = queue.shift();

        if (currentIndex === arr.length - 1) {
            return steps;
        }

        const nextIndices = [];
        if (currentIndex + 1 < arr.length) {
            nextIndices.push(currentIndex + 1);
        }
        if (currentIndex - 1 >= 0) {
            nextIndices.push(currentIndex - 1);
        }

        if (valueIndices.has(arr[currentIndex])) {
            for (const idx of valueIndices.get(arr[currentIndex])) {
                if (idx !== currentIndex) {
                    nextIndices.push(idx);
                }
            }
            valueIndices.delete(arr[currentIndex]);
        }

        for (const nextIndex of nextIndices) {
            if (!visited.has(nextIndex)) {
                visited.add(nextIndex);
                queue.push([nextIndex, steps + 1]);
            }
        }
    }

    return -1;
};