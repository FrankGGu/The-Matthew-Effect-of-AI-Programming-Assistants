var topKFrequent = function(words, k) {
    const frequencyMap = new Map();
    for (const word of words) {
        frequencyMap.set(word, (frequencyMap.get(word) || 0) + 1);
    }

    const sortedWords = Array.from(frequencyMap.keys()).sort((a, b) => {
        const countA = frequencyMap.get(a);
        const countB = frequencyMap.get(b);
        if (countA !== countB) {
            return countB - countA;
        } else {
            return a.localeCompare(b);
        }
    });

    return sortedWords.slice(0, k);
};