var countWords = function(words1, words2) {
    const freq1 = new Map();
    const freq2 = new Map();

    for (const word of words1) {
        freq1.set(word, (freq1.get(word) || 0) + 1);
    }

    for (const word of words2) {
        freq2.set(word, (freq2.get(word) || 0) + 1);
    }

    let commonCount = 0;
    for (const [word, count] of freq1.entries()) {
        if (count === 1 && freq2.get(word) === 1) {
            commonCount++;
        }
    }

    return commonCount;
};