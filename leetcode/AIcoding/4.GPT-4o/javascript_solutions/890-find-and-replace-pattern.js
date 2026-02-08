var findAndReplacePattern = function(words, pattern) {
    const matchPattern = (word, pattern) => {
        const charMap = new Map();
        const usedChars = new Set();
        for (let i = 0; i < word.length; i++) {
            const wChar = word[i];
            const pChar = pattern[i];
            if (!charMap.has(pChar)) {
                if (usedChars.has(wChar)) return false;
                charMap.set(pChar, wChar);
                usedChars.add(wChar);
            } else if (charMap.get(pChar) !== wChar) {
                return false;
            }
        }
        return true;
    };

    return words.filter(word => matchPattern(word, pattern));
};