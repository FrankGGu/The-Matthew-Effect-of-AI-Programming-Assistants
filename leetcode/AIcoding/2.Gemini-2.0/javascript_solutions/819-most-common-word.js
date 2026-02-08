var mostCommonWord = function(paragraph, banned) {
    const bannedSet = new Set(banned);
    const words = paragraph.toLowerCase().split(/\W+/).filter(word => word !== "");
    const wordCounts = {};
    let maxCount = 0;
    let mostCommon = "";

    for (const word of words) {
        if (!bannedSet.has(word)) {
            wordCounts[word] = (wordCounts[word] || 0) + 1;
            if (wordCounts[word] > maxCount) {
                maxCount = wordCounts[word];
                mostCommon = word;
            }
        }
    }

    return mostCommon;
};