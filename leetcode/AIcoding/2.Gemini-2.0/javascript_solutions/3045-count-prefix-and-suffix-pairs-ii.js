function countPrefixSuffixPairs(words) {
    let count = 0;
    const n = words.length;
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const word1 = words[i];
            const word2 = words[j];
            if (word2.startsWith(word1) && word2.endsWith(word1)) {
                count++;
            }
        }
    }
    return count;
}