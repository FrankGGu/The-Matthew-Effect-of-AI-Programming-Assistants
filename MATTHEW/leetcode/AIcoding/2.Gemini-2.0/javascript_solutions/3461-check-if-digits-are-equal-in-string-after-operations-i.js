var areOccurrencesEqual = function(s) {
    const counts = {};
    for (const char of s) {
        counts[char] = (counts[char] || 0) + 1;
    }

    const firstCount = Object.values(counts)[0];
    for (const count of Object.values(counts)) {
        if (count !== firstCount) {
            return false;
        }
    }

    return true;
};