var countPrefixSuffixPairs = function(words) {
    let count = 0;
    const n = words.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const prefix = words[i];
            const target = words[j];

            if (target.startsWith(prefix) && target.endsWith(prefix)) {
                count++;
            }
        }
    }

    return count;
};