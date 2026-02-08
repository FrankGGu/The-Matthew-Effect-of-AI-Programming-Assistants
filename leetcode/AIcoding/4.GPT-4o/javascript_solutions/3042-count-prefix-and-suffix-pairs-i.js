var countPrefixAndSuffixWords = function(words) {
    let count = 0;
    const set = new Set(words);
    for (const word of words) {
        for (let i = 1; i < word.length; i++) {
            const prefix = word.slice(0, i);
            const suffix = word.slice(i);
            if (set.has(prefix) && set.has(suffix)) {
                count++;
                break;
            }
        }
    }
    return count;
};