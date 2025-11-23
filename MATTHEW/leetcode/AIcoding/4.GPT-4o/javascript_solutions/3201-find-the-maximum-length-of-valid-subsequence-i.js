var findTheLongestValidSubstring = function(word, forbidden) {
    const forbiddenSet = new Set(forbidden);
    let maxLength = 0;
    let left = 0;

    for (let right = 0; right < word.length; right++) {
        while (forbiddenSet.has(word.slice(left, right + 1))) {
            left++;
        }
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};