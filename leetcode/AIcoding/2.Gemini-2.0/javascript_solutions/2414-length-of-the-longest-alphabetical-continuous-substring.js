var longestContinuousSubstring = function(s) {
    let maxLength = 1;
    let currentLength = 1;
    for (let i = 1; i < s.length; i++) {
        if (s.charCodeAt(i) - s.charCodeAt(i - 1) === 1) {
            currentLength++;
        } else {
            maxLength = Math.max(maxLength, currentLength);
            currentLength = 1;
        }
    }
    maxLength = Math.max(maxLength, currentLength);
    return maxLength;
};