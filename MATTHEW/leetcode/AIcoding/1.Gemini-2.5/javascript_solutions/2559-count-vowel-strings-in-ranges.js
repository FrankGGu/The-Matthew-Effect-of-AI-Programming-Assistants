var vowelStrings = function(words, queries) {
    const vowels = new Set(['a', 'e', 'i', 'o', 'u']);

    const isVowelChar = (char) => vowels.has(char);

    const prefixVowelCounts = new Array(words.length + 1).fill(0);

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const isVowelStr = isVowelChar(word[0]) && isVowelChar(word[word.length - 1]);
        prefixVowelCounts[i + 1] = prefixVowelCounts[i] + (isVowelStr ? 1 : 0);
    }

    const results = [];
    for (let i = 0; i < queries.length; i++) {
        const [start, end] = queries[i];
        results.push(prefixVowelCounts[end + 1] - prefixVowelCounts[start]);
    }

    return results;
};