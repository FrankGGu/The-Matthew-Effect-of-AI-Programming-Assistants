var countPairs = function(words, target) {
    let count = 0;
    const wordMap = new Map();

    for (const word of words) {
        const complement = target.slice(0, target.length - word.length);
        if (wordMap.has(complement)) {
            count += wordMap.get(complement);
        }
        wordMap.set(word, (wordMap.get(word) || 0) + 1);
    }

    return count;
};