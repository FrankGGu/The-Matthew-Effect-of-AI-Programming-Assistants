function longestSemiRepetitiveSubstring(s) {
    let n = s.length;
    let maxLen = 0;
    for (let i = 0; i < n; i++) {
        let count = 0;
        for (let j = i; j < n; j++) {
            if (j > 0 && s[j] === s[j - 1]) {
                count++;
            }
            if (count <= 1) {
                maxLen = Math.max(maxLen, j - i + 1);
            } else {
                break;
            }
        }
    }
    return maxLen;
}