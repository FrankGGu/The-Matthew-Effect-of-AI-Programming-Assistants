var longestSemiRepetitiveSubstring = function(s) {
    let maxLen = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            let sub = s.substring(i, j + 1);
            let count = 0;
            for (let k = 0; k < sub.length - 1; k++) {
                if (sub[k] === sub[k + 1]) {
                    count++;
                }
            }
            if (count <= 1) {
                maxLen = Math.max(maxLen, sub.length);
            }
        }
    }
    return maxLen;
};