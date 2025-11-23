var findAndReplacePattern = function(words, pattern) {
    const match = (word, pattern) => {
        if (word.length !== pattern.length) return false;
        const map = new Map();
        const seen = new Set();
        for (let i = 0; i < word.length; i++) {
            const charWord = word[i];
            const charPattern = pattern[i];
            if (!map.has(charPattern)) {
                if (seen.has(charWord)) return false;
                map.set(charPattern, charWord);
                seen.add(charWord);
            } else {
                if (map.get(charPattern) !== charWord) return false;
            }
        }
        return true;
    };

    const result = [];
    for (const word of words) {
        if (match(word, pattern)) {
            result.push(word);
        }
    }
    return result;
};