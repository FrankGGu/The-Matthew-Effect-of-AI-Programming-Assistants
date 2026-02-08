var topKFrequent = function(words, k) {
    const freqMap = new Map();
    for (const word of words) {
        freqMap.set(word, (freqMap.get(word) || 0) + 1);
    }

    const uniqueWords = Array.from(freqMap.keys());

    uniqueWords.sort((a, b) => {
        const freqA = freqMap.get(a);
        const freqB = freqMap.get(b);

        if (freqA !== freqB) {
            return freqB - freqA;
        } else {
            return a.localeCompare(b);
        }
    });

    return uniqueWords.slice(0, k);
};