var lengthOfLongestSubstring = function(s) {
    let map = new Map();
    let left = 0, maxLength = 0;

    for (let right = 0; right < s.length; right++) {
        if (map.has(s[right])) {
            left = Math.max(map.get(s[right]) + 1, left);
        }
        map.set(s[right], right);
        maxLength = Math.max(maxLength, right - left + 1);
    }

    return maxLength;
};