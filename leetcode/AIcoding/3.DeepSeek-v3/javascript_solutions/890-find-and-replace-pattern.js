var findAndReplacePattern = function(words, pattern) {
    const matchesPattern = (word, pattern) => {
        const map1 = new Map();
        const map2 = new Map();
        for (let i = 0; i < word.length; i++) {
            const w = word[i];
            const p = pattern[i];
            if (!map1.has(w)) map1.set(w, p);
            if (!map2.has(p)) map2.set(p, w);
            if (map1.get(w) !== p || map2.get(p) !== w) return false;
        }
        return true;
    };
    return words.filter(word => matchesPattern(word, pattern));
};