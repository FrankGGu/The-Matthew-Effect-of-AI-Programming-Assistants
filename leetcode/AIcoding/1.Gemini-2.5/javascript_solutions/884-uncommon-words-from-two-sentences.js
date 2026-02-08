var uncommonFromSentences = function(s1, s2) {
    const wordCounts = new Map();

    s1.split(' ').forEach(word => {
        wordCounts.set(word, (wordCounts.get(word) || 0) + 1);
    });

    s2.split(' ').forEach(word => {
        wordCounts.set(word, (wordCounts.get(word) || 0) + 1);
    });

    const uncommonWords = [];
    for (const [word, count] of wordCounts.entries()) {
        if (count === 1) {
            uncommonWords.push(word);
        }
    }

    return uncommonWords;
};