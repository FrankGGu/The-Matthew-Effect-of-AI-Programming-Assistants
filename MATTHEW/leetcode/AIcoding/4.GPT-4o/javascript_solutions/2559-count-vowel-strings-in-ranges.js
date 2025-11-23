var vowelStrings = function(words, queries) {
    const isVowelString = (s) => {
        return 'aeiou'.includes(s[0]) && 'aeiou'.includes(s[s.length - 1]);
    };

    const prefixSum = new Array(words.length + 1).fill(0);
    for (let i = 0; i < words.length; i++) {
        prefixSum[i + 1] = prefixSum[i] + (isVowelString(words[i]) ? 1 : 0);
    }

    const result = [];
    for (const [start, end] of queries) {
        result.push(prefixSum[end + 1] - prefixSum[start]);
    }
    return result;
};