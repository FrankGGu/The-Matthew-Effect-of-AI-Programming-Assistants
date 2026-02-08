var lastSubstring = function(s) {
    let maxChar = 'a';
    let maxSubstring = '';

    for (let i = s.length - 1; i >= 0; i--) {
        if (s[i] >= maxChar) {
            maxChar = s[i];
            maxSubstring = s.substring(i);
        }
    }

    return maxSubstring;
};