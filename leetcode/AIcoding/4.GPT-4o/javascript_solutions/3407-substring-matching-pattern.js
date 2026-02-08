function findAndReplacePattern(words, pattern) {
    const matches = (word, pattern) => {
        const map1 = new Map(), map2 = new Map();
        for (let i = 0; i < word.length; i++) {
            const wChar = word[i], pChar = pattern[i];
            if (!map1.has(wChar)) map1.set(wChar, pChar);
            if (!map2.has(pChar)) map2.set(pChar, wChar);
            if (map1.get(wChar) !== pChar || map2.get(pChar) !== wChar) return false;
        }
        return true;
    };

    return words.filter(word => matches(word, pattern));
}