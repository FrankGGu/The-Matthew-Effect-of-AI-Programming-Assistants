var longestBeautifulSubstring = function(word) {
    let maxLen = 0;
    let currentLen = 1;
    let uniqueVowels = 1;

    for (let i = 1; i < word.length; i++) {
        if (word[i] >= word[i - 1]) {
            currentLen++;
            if (word[i] !== word[i - 1]) {
                uniqueVowels++;
            }
        } else {
            currentLen = 1;
            uniqueVowels = 1;
        }

        if (uniqueVowels === 5) {
            maxLen = Math.max(maxLen, currentLen);
        }
    }

    return maxLen;
};