var countConsistentStrings = function(allowed, words) {
    let count = 0;
    const allowedSet = new Set(allowed);
    for (const word of words) {
        let consistent = true;
        for (const char of word) {
            if (!allowedSet.has(char)) {
                consistent = false;
                break;
            }
        }
        if (consistent) {
            count++;
        }
    }
    return count;
};