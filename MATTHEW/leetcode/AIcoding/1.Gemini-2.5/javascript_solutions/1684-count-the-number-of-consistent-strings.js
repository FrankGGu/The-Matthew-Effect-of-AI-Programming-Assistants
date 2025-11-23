var countConsistentStrings = function(allowed, words) {
    const allowedChars = new Set();
    for (const char of allowed) {
        allowedChars.add(char);
    }

    let consistentCount = 0;
    for (const word of words) {
        let isConsistent = true;
        for (const char of word) {
            if (!allowedChars.has(char)) {
                isConsistent = false;
                break;
            }
        }
        if (isConsistent) {
            consistentCount++;
        }
    }

    return consistentCount;
};