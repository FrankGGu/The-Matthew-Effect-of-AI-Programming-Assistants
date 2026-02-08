var countPairs = function(words) {
    let count = 0;
    const wordSet = new Set(words);

    for (const word of words) {
        const length = word.length;
        for (let i = 1; i < length; i++) {
            const prefix = word.slice(0, i);
            const suffix = word.slice(i);
            if (wordSet.has(prefix) && wordSet.has(suffix)) {
                count++;
            }
        }
    }

    return count;
};