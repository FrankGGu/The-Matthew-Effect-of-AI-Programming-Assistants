var findOriginalArray = function(changed) {
    if (changed.length % 2 !== 0) {
        return [];
    }

    const n = changed.length / 2;
    const original = [];
    const count = new Map();

    for (const num of changed) {
        count.set(num, (count.get(num) || 0) + 1);
    }

    changed.sort((a, b) => a - b);

    for (const num of changed) {
        if (count.get(num) > 0) {
            const doubled = num * 2;
            if (count.get(doubled) > 0) {
                original.push(num);
                count.set(num, count.get(num) - 1);
                count.set(doubled, count.get(doubled) - 1);
            } else {
                return [];
            }
        }
    }

    if (original.length !== n) {
        return [];
    }

    return original;
};