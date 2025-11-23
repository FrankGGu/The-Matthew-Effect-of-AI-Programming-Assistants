var maxPower = function(s) {
    let maxLength = 1, currentLength = 1;
    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            currentLength++;
        } else {
            maxLength = Math.max(maxLength, currentLength);
            currentLength = 1;
        }
    }
    return Math.max(maxLength, currentLength);
};