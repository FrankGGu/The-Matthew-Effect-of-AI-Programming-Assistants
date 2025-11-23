var areOccurrencesEqual = function(s) {
    const counts = {};
    for (const char of s) {
        counts[char] = (counts[char] || 0) + 1;
    }

    const firstCount = counts[s[0]];
    for (const char in counts) {
        if (counts[char] !== firstCount) {
            return false;
        }
    }

    return true;
};