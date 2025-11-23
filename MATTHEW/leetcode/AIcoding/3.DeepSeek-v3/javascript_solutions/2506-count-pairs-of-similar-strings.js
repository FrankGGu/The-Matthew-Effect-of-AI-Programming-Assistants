var similarPairs = function(words) {
    const countSimilar = (word) => {
        const set = new Set(word.split(''));
        const sorted = Array.from(set).sort().join('');
        return sorted;
    };

    const map = new Map();
    let res = 0;

    for (const word of words) {
        const key = countSimilar(word);
        if (map.has(key)) {
            res += map.get(key);
            map.set(key, map.get(key) + 1);
        } else {
            map.set(key, 1);
        }
    }

    return res;
};