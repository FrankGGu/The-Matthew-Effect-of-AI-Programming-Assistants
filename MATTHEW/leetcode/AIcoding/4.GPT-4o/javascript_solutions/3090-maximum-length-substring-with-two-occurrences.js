var maxLength = function(s) {
    let maxLen = 0;
    let n = s.length;

    for (let i = 0; i < n; i++) {
        let count = {};
        for (let j = i; j < n; j++) {
            count[s[j]] = (count[s[j]] || 0) + 1;
            if (count[s[j]] > 2) break;
            if (Object.keys(count).length <= 2) {
                maxLen = Math.max(maxLen, j - i + 1);
            }
        }
    }
    return maxLen;
};