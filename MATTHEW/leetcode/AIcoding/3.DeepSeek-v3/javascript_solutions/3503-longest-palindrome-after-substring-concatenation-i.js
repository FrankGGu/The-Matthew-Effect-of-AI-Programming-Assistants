var longestPalindrome = function(s) {
    let maxLen = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            let substr = s.substring(i, j + 1);
            let reversed = substr.split('').reverse().join('');
            if (substr === reversed) {
                maxLen = Math.max(maxLen, substr.length);
            }
        }
    }
    return maxLen;
};