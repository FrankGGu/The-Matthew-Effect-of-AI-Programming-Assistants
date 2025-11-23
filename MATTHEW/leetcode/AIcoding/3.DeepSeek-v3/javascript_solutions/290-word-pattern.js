var wordPattern = function(pattern, s) {
    const words = s.split(' ');
    if (pattern.length !== words.length) return false;

    const patternMap = new Map();
    const wordMap = new Map();

    for (let i = 0; i < pattern.length; i++) {
        const p = pattern[i];
        const w = words[i];

        if (patternMap.has(p) !== wordMap.has(w)) {
            return false;
        }

        if (patternMap.has(p)) {
            if (patternMap.get(p) !== w || wordMap.get(w) !== p) {
                return false;
            }
        } else {
            patternMap.set(p, w);
            wordMap.set(w, p);
        }
    }

    return true;
};