var topKFrequent = function(words, k) {
    const count = {};
    words.forEach(word => {
        count[word] = (count[word] || 0) + 1;
    });

    const sortedWords = Object.keys(count).sort((a, b) => {
        if (count[a] === count[b]) {
            return a.localeCompare(b);
        }
        return count[b] - count[a];
    });

    return sortedWords.slice(0, k);
};