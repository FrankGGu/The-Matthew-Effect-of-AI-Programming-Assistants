var longestContinuousSubstring = function(s) {
    let maxLen = 1;
    let currentLen = 1;

    for (let i = 1; i < s.length; i++) {
        if (s.charCodeAt(i) === s.charCodeAt(i - 1) + 1) {
            currentLen++;
            maxLen = Math.max(maxLen, currentLen);
        } else {
            currentLen = 1;
        }
    }

    return maxLen;
};