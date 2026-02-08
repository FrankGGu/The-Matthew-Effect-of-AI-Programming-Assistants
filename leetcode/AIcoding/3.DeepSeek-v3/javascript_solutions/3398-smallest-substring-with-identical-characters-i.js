var smallestSubstringWithIdenticalChars = function(s) {
    let minLen = Infinity;
    let currentLen = 1;

    for (let i = 1; i < s.length; i++) {
        if (s[i] === s[i - 1]) {
            currentLen++;
        } else {
            if (currentLen < minLen) {
                minLen = currentLen;
            }
            currentLen = 1;
        }
    }

    if (currentLen < minLen) {
        minLen = currentLen;
    }

    return minLen === Infinity ? 1 : minLen;
};