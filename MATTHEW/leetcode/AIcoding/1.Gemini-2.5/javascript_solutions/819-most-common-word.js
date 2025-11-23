var mostCommonWord = function(paragraph, banned) {
    const bannedSet = new Set(banned);
    const wordCounts = new Map();

    const normalizedParagraph = paragraph.toLowerCase().replace(/[^a-z]+/g, ' ');
    const words = normalizedParagraph.split(' ').filter(word => word.length > 0);

    for (const word of words) {
        if (!bannedSet.has(word)) {
            wordCounts.set(word, (wordCounts.get(word) || 0) + 1);
        }
    }

    let maxCount = 0;
    let mostFrequentWord = '';

    for (const [word, count] of wordCounts.entries()) {
        if (count > maxCount) {
            maxCount = count;
            mostFrequentWord = word;
        }
    }

    return mostFrequentWord;
};