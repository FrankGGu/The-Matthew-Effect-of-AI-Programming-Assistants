var findLongestSpecialSubstring = function(s) {
    let maxLen = 0;
    let n = s.length;

    for (let len = 1; len <= n; len++) {
        let count = {};
        for (let i = 0; i <= n - len; i++) {
            let substr = s.substring(i, i + len);
            count[substr] = (count[substr] || 0) + 1;
        }

        for (let substr in count) {
            if (count[substr] === 3) {
                maxLen = Math.max(maxLen, substr.length);
            }
        }
    }

    return maxLen;
};