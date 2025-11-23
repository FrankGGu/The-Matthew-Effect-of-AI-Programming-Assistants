var mostCommonWord = function(paragraph, banned) {
    const bannedSet = new Set(banned);
    const words = paragraph.toLowerCase().split(/\W+/);
    const frequency = {};
    let maxCount = 0;
    let result = '';

    for (const word of words) {
        if (!bannedSet.has(word) && word !== '') {
            frequency[word] = (frequency[word] || 0) + 1;
            if (frequency[word] > maxCount) {
                maxCount = frequency[word];
                result = word;
            }
        }
    }

    return result;
};