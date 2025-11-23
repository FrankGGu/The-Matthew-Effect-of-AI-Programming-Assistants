var mostCommonWord = function(paragraph, banned) {
    const bannedSet = new Set(banned.map(word => word.toLowerCase()));
    const words = paragraph.toLowerCase().split(/\W+/);
    const freq = {};
    let maxFreq = 0;
    let result = '';

    for (const word of words) {
        if (word === '') continue;
        if (!bannedSet.has(word)) {
            freq[word] = (freq[word] || 0) + 1;
            if (freq[word] > maxFreq) {
                maxFreq = freq[word];
                result = word;
            }
        }
    }

    return result;
};