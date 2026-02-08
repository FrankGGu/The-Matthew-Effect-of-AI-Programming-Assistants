var longestSubstring = function(s, k) {
    if (s.length === 0 || k > s.length) return 0;
    if (k <= 1) return s.length;

    const counts = {};
    for (const char of s) {
        counts[char] = (counts[char] || 0) + 1;
    }

    for (const char of Object.keys(counts)) {
        if (counts[char] < k) {
            let maxLen = 0;
            const substrings = s.split(char);
            for (const sub of substrings) {
                maxLen = Math.max(maxLen, longestSubstring(sub, k));
            }
            return maxLen;
        }
    }

    return s.length;
};