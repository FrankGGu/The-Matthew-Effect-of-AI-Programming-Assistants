var longestSubstring = function(s) {
    const vowels = "aeiou";
    let maxLength = 0;
    let currentLength = 0;
    let lastIndex = -1;

    for (let i = 0; i < s.length; i++) {
        let index = vowels.indexOf(s[i]);
        if (index === -1) {
            currentLength = 0;
            lastIndex = -1;
        } else if (index === lastIndex + 1) {
            currentLength++;
        } else if (index === 0) {
            currentLength = 1;
        } else {
            currentLength = 0;
        }
        lastIndex = index;
        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};