var numEquivDominoPairs = function(dominoes) {
    let count = 0;
    const map = new Map();

    for (const domino of dominoes) {
        const sortedDomino = domino[0] <= domino[1] ? [domino[0], domino[1]] : [domino[1], domino[0]];
        const key = sortedDomino[0] * 10 + sortedDomino[1];
        if (map.has(key)) {
            count += map.get(key);
            map.set(key, map.get(key) + 1);
        } else {
            map.set(key, 1);
        }
    }

    return count;
};