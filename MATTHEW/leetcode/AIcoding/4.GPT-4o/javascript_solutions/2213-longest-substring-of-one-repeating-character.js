var lengthOfLongestSubstring = function(s) {
    let left = 0, right = 0, maxLen = 0;
    const charIndexMap = new Map();

    while (right < s.length) {
        if (charIndexMap.has(s[right])) {
            left = Math.max(charIndexMap.get(s[right]) + 1, left);
        }
        charIndexMap.set(s[right], right);
        maxLen = Math.max(maxLen, right - left + 1);
        right++;
    }

    return maxLen;
};