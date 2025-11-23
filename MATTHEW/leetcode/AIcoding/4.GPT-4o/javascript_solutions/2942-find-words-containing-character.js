var findWords = function(words, chars) {
    const charCount = {};
    for (const char of chars) {
        charCount[char] = (charCount[char] || 0) + 1;
    }

    const canFormWord = (word) => {
        const wordCount = {};
        for (const char of word) {
            wordCount[char] = (wordCount[char] || 0) + 1;
            if (wordCount[char] > (charCount[char] || 0)) {
                return false;
            }
        }
        return true;
    };

    return words.filter(canFormWord);
};