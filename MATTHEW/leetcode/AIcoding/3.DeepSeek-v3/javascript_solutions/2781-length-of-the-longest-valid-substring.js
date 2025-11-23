var longestValidSubstring = function(word, forbidden) {
    const forbiddenSet = new Set(forbidden);
    let maxLen = 0;
    let left = 0;
    const n = word.length;

    for (let right = 0; right < n; right++) {
        for (let i = right; i >= left && i >= right - 10; i--) {
            const substring = word.substring(i, right + 1);
            if (forbiddenSet.has(substring)) {
                left = i + 1;
                break;
            }
        }
        maxLen = Math.max(maxLen, right - left + 1);
    }

    return maxLen;
};