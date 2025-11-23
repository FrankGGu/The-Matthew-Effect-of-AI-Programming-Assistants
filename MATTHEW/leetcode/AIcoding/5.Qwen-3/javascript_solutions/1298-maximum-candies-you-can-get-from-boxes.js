function maxCandies(boxes, keys, containedBoxes, initialBoxes) {
    const visited = new Set();
    const haveKey = new Set();
    const queue = [];
    let count = 0;

    for (const box of initialBoxes) {
        queue.push(box);
        visited.add(box);
    }

    for (const key of keys) {
        haveKey.add(key);
    }

    while (queue.length > 0) {
        const box = queue.shift();
        count += boxes[box];
        for (const child of containedBoxes[box]) {
            if (!visited.has(child)) {
                visited.add(child);
                queue.push(child);
            }
        }
        for (const key of keys) {
            if (haveKey.has(key)) {
                for (const child of containedBoxes[key]) {
                    if (!visited.has(child)) {
                        visited.add(child);
                        queue.push(child);
                    }
                }
            }
        }
    }

    return count;
}