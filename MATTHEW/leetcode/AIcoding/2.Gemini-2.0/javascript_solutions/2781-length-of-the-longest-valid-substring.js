var longestValidSubstring = function(word, forbidden) {
    const forbiddenSet = new Set(forbidden);
    let maxLen = 0;
    for (let i = 0; i < word.length; i++) {
        for (let j = i; j < word.length; j++) {
            const sub = word.substring(i, j + 1);
            if (!forbiddenSet.has(sub)) {
                maxLen = Math.max(maxLen, sub.length);
            } else {
                break;
            }
        }
    }
    return maxLen;
};