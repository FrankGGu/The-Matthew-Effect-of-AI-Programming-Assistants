var vowelStrings = function(words, queries) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);
    const prefix = [0];
    for (const word of words) {
        const last = prefix[prefix.length - 1];
        if (vowels.has(word[0]) && vowels.has(word[word.length - 1])) {
            prefix.push(last + 1);
        } else {
            prefix.push(last);
        }
    }
    const result = [];
    for (const [l, r] of queries) {
        result.push(prefix[r + 1] - prefix[l]);
    }
    return result;
};