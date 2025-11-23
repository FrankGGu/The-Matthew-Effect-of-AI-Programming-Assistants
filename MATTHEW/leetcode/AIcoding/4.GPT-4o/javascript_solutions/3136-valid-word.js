var isValidWord = function(word, allowed) {
    const allowedSet = new Set(allowed);
    for (const char of word) {
        if (!allowedSet.has(char)) {
            return false;
        }
    }
    return true;
};