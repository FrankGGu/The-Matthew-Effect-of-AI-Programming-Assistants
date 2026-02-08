var makeEqual = function(words) {
    const count = {};
    const n = words.length;

    for (const word of words) {
        for (const char of word) {
            count[char] = (count[char] || 0) + 1;
        }
    }

    for (const key in count) {
        if (count[key] % n !== 0) {
            return false;
        }
    }

    return true;
};