var numEquivDominoPairs = function(dominoes) {
    const map = new Map();
    let count = 0;

    for (const [a, b] of dominoes) {
        const key = a < b ? `${a},${b}` : `${b},${a}`;
        if (map.has(key)) {
            count += map.get(key);
            map.set(key, map.get(key) + 1);
        } else {
            map.set(key, 1);
        }
    }

    return count;
};