var similarPairs = function(words) {
    const charSetCounts = new Map();

    for (const word of words) {
        const uniqueChars = new Set();
        for (const char of word) {
            uniqueChars.add(char);
        }
        const sortedUniqueChars = Array.from(uniqueChars).sort().join('');
        charSetCounts.set(sortedUniqueChars, (charSetCounts.get(sortedUniqueChars) || 0) + 1);
    }

    let totalPairs = 0;
    for (const count of charSetCounts.values()) {
        if (count > 1) {
            totalPairs += (count * (count - 1)) / 2;
        }
    }

    return totalPairs;
};