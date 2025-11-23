var countPrefixSuffixPairs = function(words) {
    let count = 0;
    const n = words.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const word = words[i];
            const candidate = words[j];
            if (candidate.startsWith(word) && candidate.endsWith(word)) {
                count++;
            }
        }
    }

    return count;
};