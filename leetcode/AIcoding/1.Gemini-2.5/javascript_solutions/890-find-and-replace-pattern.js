var findAndReplacePattern = function(words, pattern) {
    function getNormalized(s) {
        const charMap = new Map();
        let normalizedStr = "";
        let charCounter = 0;

        for (const char of s) {
            if (!charMap.has(char)) {
                charMap.set(char, charCounter);
                charCounter++;
            }
            normalizedStr += charMap.get(char);
        }
        return normalizedStr;
    }

    const normalizedPattern = getNormalized(pattern);
    const result = [];

    for (const word of words) {
        if (getNormalized(word) === normalizedPattern) {
            result.push(word);
        }
    }

    return result;
};