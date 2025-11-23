function longestBeautifulSubstring(s) {
    let maxLen = 0;
    let currentLen = 1;
    let prevChar = s[0];

    for (let i = 1; i < s.length; i++) {
        if (s[i] >= prevChar) {
            currentLen++;
        } else {
            currentLen = 1;
        }
        prevChar = s[i];
        if (currentLen > maxLen) {
            maxLen = currentLen;
        }
    }

    return maxLen;
}