var maxLengthBetweenEqualCharacters = function(s) {
    const firstOccurrence = {};
    let maxLen = -1;

    for (let i = 0; i < s.length; i++) {
        const char = s[i];
        if (firstOccurrence[char] !== undefined) {
            maxLen = Math.max(maxLen, i - firstOccurrence[char] - 1);
        } else {
            firstOccurrence[char] = i;
        }
    }

    return maxLen;
};