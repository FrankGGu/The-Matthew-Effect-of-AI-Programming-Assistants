var longestNiceSubstring = function(s) {
    let maxLen = 0;
    let startIndex = 0;

    const isNice = (substr) => {
        const charSet = new Set(substr);
        for (let char of charSet) {
            if (!charSet.has(char.toLowerCase()) || !charSet.has(char.toUpperCase())) {
                return false;
            }
        }
        return true;
    };

    for (let i = 0; i < s.length; i++) {
        for (let j = i + 1; j <= s.length; j++) {
            const substr = s.substring(i, j);
            if (isNice(substr) && substr.length > maxLen) {
                maxLen = substr.length;
                startIndex = i;
            }
        }
    }

    return s.substring(startIndex, startIndex + maxLen);
};