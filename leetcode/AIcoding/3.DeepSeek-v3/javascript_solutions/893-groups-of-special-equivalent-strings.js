var numSpecialEquivGroups = function(words) {
    const groups = new Set();
    for (const word of words) {
        const odd = [];
        const even = [];
        for (let i = 0; i < word.length; i++) {
            if (i % 2 === 0) {
                even.push(word[i]);
            } else {
                odd.push(word[i]);
            }
        }
        const key = even.sort().join('') + odd.sort().join('');
        groups.add(key);
    }
    return groups.size;
};