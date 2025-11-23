var countConsistentStrings = function(allowed, words) {
    const allowedSet = new Set(allowed);
    let count = 0;

    for (const word of words) {
        if (Array.from(word).every(char => allowedSet.has(char))) {
            count++;
        }
    }

    return count;
};