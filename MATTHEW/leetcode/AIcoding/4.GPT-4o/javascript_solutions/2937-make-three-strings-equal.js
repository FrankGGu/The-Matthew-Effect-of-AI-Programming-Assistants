function makeEqual(words) {
    const count = {};
    for (const word of words) {
        for (const char of word) {
            count[char] = (count[char] || 0) + 1;
        }
    }
    const n = words.length;
    for (const char in count) {
        if (count[char] % n !== 0) {
            return false;
        }
    }
    return true;
}