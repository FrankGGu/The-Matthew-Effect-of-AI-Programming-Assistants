var uncommonFromSentences = function(s1, s2) {
    const words1 = s1.split(" ");
    const words2 = s2.split(" ");

    const freq = {};

    for (const word of words1) {
        freq[word] = (freq[word] || 0) + 1;
    }

    for (const word of words2) {
        freq[word] = (freq[word] || 0) + 1;
    }

    const result = [];
    for (const word in freq) {
        if (freq[word] === 1) {
            result.push(word);
        }
    }

    return result;
};