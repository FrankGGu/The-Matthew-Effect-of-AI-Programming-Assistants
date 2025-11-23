var lengthOfLongestSubstring = function(s) {
    let maxLength = 0;
    let start = 0;
    let charMap = {};

    for (let i = 0; i < s.length; i++) {
        let char = s[i];
        if (charMap[char] !== undefined && charMap[char] >= start) {
            start = charMap[char] + 1;
        }
        charMap[char] = i;
        maxLength = Math.max(maxLength, i - start + 1);
    }

    return maxLength;
};