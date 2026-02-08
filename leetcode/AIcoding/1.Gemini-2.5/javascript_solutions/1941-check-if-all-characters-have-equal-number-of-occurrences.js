var areOccurrencesEqual = function(s) {
    const charCounts = new Map();

    for (const char of s) {
        charCounts.set(char, (charCounts.get(char) || 0) + 1);
    }

    if (charCounts.size === 0) {
        return true;
    }

    let firstCount = -1;
    for (const count of charCounts.values()) {
        if (firstCount === -1) {
            firstCount = count;
        } else if (count !== firstCount) {
            return false;
        }
    }

    return true;
};