function largestSubstringBetweenTwoEqualCharacters(s) {
    let maxLen = -1;
    const lastIndex = {};

    for (let i = 0; i < s.length; i++) {
        if (lastIndex.hasOwnProperty(s[i])) {
            const len = i - lastIndex[s[i]] - 1;
            if (len > maxLen) {
                maxLen = len;
            }
        } else {
            lastIndex[s[i]] = i;
        }
    }

    return maxLen;
}