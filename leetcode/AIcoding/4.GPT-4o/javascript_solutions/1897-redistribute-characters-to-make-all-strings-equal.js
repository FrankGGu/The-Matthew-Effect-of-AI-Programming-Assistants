var makeEqual = function(words) {
    const count = {};
    for (const word of words) {
        for (const char of word) {
            count[char] = (count[char] || 0) + 1;
        }
    }
    const n = words.length;
    return Object.values(count).every(v => v % n === 0);
};