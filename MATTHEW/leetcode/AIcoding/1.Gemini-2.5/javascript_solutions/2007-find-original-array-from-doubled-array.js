var findOriginalArray = function(changed) {
    if (changed.length % 2 !== 0) {
        return [];
    }

    const counts = new Map();
    for (const num of changed) {
        counts.set(num, (counts.get(num) || 0) + 1);
    }

    changed.sort((a, b) => a - b);

    const original = [];
    for (const num of changed) {
        if (counts.get(num) === 0) {
            continue;
        }

        // Decrement count for num
        counts.set(num, counts.get(num) - 1);

        const doubledNum = num * 2;

        if (counts.has(doubledNum) && counts.get(doubledNum) > 0) {
            // Decrement count for doubledNum
            counts.set(doubledNum, counts.get(doubledNum) - 1);
            original.push(num);
        } else {
            // If doubledNum is not found or its count is 0, it's not a valid doubled array
            return [];
        }
    }

    return original;
};