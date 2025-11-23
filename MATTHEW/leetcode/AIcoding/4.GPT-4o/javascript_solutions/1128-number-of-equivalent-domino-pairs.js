var numEquivDominoPairs = function(dominoes) {
    let count = 0;
    const map = new Map();

    for (const [a, b] of dominoes) {
        const key = a < b ? `${a},${b}` : `${b},${a}`;
        map.set(key, (map.get(key) || 0) + 1);
    }

    for (const value of map.values()) {
        count += (value * (value - 1)) / 2;
    }

    return count;
};