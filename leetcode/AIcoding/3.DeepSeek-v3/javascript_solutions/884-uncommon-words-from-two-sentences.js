var uncommonFromSentences = function(s1, s2) {
    const words1 = s1.split(' ');
    const words2 = s2.split(' ');
    const count = {};

    for (const word of words1) {
        count[word] = (count[word] || 0) + 1;
    }

    for (const word of words2) {
        count[word] = (count[word] || 0) + 1;
    }

    const result = [];
    for (const word in count) {
        if (count[word] === 1) {
            result.push(word);
        }
    }

    return result;
};