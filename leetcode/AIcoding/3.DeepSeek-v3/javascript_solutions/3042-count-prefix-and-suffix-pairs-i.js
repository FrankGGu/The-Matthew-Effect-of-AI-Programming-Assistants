var countPrefixSuffixPairs = function(words) {
    let count = 0;
    for (let i = 0; i < words.length; i++) {
        for (let j = i + 1; j < words.length; j++) {
            const word = words[i];
            const candidate = words[j];
            if (candidate.startsWith(word) && candidate.endsWith(word)) {
                count++;
            }
        }
    }
    return count;
};