var longestSubstring = function(s, k) {
    if (s.length === 0 || s.length < k) {
        return 0;
    }

    const counts = new Array(26).fill(0);
    for (let i = 0; i < s.length; i++) {
        counts[s.charCodeAt(i) - 'a'.charCodeAt(0)]++;
    }

    let splitChar = '';
    for (let i = 0; i < 26; i++) {
        if (counts[i] > 0 && counts[i] < k) {
            splitChar = String.fromCharCode('a'.charCodeAt(0) + i);
            break;
        }
    }

    if (splitChar === '') {
        return s.length;
    }

    let maxLen = 0;
    let start = 0;
    for (let i = 0; i < s.length; i++) {
        if (s[i] === splitChar) {
            if (i > start) {
                maxLen = Math.max(maxLen, longestSubstring(s.substring(start, i), k));
            }
            start = i + 1;
        }
    }

    if (start < s.length) {
        maxLen = Math.max(maxLen, longestSubstring(s.substring(start, s.length), k));
    }

    return maxLen;
};