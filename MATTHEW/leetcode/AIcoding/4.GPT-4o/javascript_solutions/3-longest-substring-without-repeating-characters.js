var lengthOfLongestSubstring = function(s) {
    let charMap = new Map();
    let left = 0, maxLength = 0;

    for (let right = 0; right < s.length; right++) {
        if (charMap.has(s[right])) {
            left = Math.max(charMap.get(s[right]) + 1, left);
        }
        charMap.set(s[right], right);
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};