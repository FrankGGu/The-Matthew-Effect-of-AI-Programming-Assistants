var mostCommonWord = function(paragraph, banned) {
    const map = new Map();
    const words = paragraph.toLowerCase().replace(/[^a-zA-Z\s]/g, ' ').split(/\s+/);
    const bannedSet = new Set(banned);

    for (const word of words) {
        if (!bannedSet.has(word) && word) {
            map.set(word, (map.get(word) || 0) + 1);
        }
    }

    let maxCount = 0;
    let mostCommon = '';

    for (const [word, count] of map) {
        if (count > maxCount) {
            maxCount = count;
            mostCommon = word;
        }
    }

    return mostCommon;
};