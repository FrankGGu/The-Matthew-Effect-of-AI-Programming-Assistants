var longestSubstring = function(s, k) {
    if (s.length < k) return 0;
    const countMap = {};
    for (const char of s) {
        countMap[char] = (countMap[char] || 0) + 1;
    }
    for (const char in countMap) {
        if (countMap[char] < k) {
            let max = 0;
            for (const substr of s.split(char)) {
                max = Math.max(max, longestSubstring(substr, k));
            }
            return max;
        }
    }
    return s.length;
};