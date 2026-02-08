var vowelStrings = function(words, queries) {
    const vowels = ['a', 'e', 'i', 'o', 'u'];
    const prefixSum = new Array(words.length + 1).fill(0);
    for (let i = 0; i < words.length; i++) {
        const first = words[i][0];
        const last = words[i][words[i].length - 1];
        if (vowels.includes(first) && vowels.includes(last)) {
            prefixSum[i + 1] = prefixSum[i] + 1;
        } else {
            prefixSum[i + 1] = prefixSum[i];
        }
    }

    const result = [];
    for (const query of queries) {
        const start = query[0];
        const end = query[1];
        result.push(prefixSum[end + 1] - prefixSum[start]);
    }

    return result;
};