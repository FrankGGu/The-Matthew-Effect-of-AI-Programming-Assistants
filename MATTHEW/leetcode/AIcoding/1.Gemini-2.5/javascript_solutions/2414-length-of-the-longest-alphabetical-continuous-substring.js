var longestContinuousSubstring = function(s) {
    if (s.length === 0) {
        return 0;
    }

    let maxLength = 1;
    let currentLength = 1;

    for (let i = 1; i < s.length; i++) {
        if (s.charCodeAt(i) - s.charCodeAt(i - 1) === 1) {
            currentLength++;
        } else {
            currentLength = 1;
        }
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};