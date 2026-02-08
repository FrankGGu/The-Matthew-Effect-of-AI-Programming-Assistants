var maxLengthBetweenEqualCharacters = function(s) {
    let maxLength = -1;
    for (let i = 0; i < s.length; i++) {
        for (let j = s.length - 1; j > i; j--) {
            if (s[i] === s[j]) {
                maxLength = Math.max(maxLength, j - i - 1);
                break;
            }
        }
    }
    return maxLength;
};