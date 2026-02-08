var maxCandies = function(status, candies, keys, containedBoxes, initialBoxes) {
    let totalCandies = 0;
    let queue = [];
    let ownedBoxes = new Set();
    let ownedKeys = new Set();

    for (let box of initialBoxes) {
        if (status[box] === 1) {
            queue.push(box);
        } else {
            ownedBoxes.add(box);
        }
    }

    while (queue.length > 0) {
        let currentBox = queue.shift();
        totalCandies += candies[currentBox];

        for (let key of keys[currentBox]) {
            if (ownedBoxes.has(key) && !ownedKeys.has(key)) {
                queue.push(key);
                ownedBoxes.delete(key);
            } else {
                ownedKeys.add(key);
            }
        }

        for (let box of containedBoxes[currentBox]) {
            if (status[box] === 1 || ownedKeys.has(box)) {
                queue.push(box);
            } else {
                ownedBoxes.add(box);
            }
        }
    }

    return totalCandies;
};