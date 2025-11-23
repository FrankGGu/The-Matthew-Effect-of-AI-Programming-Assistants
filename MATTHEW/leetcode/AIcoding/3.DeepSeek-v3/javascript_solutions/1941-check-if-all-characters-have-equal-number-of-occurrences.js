var areOccurrencesEqual = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const values = Object.values(freq);
    const first = values[0];
    return values.every(v => v === first);
};