var makeEqual = function(words) {
    const counts = {};
    for (const word of words) {
        for (const char of word) {
            counts[char] = (counts[char] || 0) + 1;
        }
    }
    const n = words.length;
    for (const char in counts) {
        if (counts[char] % n !== 0) {
            return false;
        }
    }
    return true;
};