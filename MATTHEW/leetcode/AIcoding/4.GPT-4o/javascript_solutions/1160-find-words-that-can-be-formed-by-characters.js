var countCharacters = function(words, chars) {
    const charCount = {};
    for (const char of chars) {
        charCount[char] = (charCount[char] || 0) + 1;
    }

    let totalLength = 0;

    for (const word of words) {
        const wordCount = {};
        for (const char of word) {
            wordCount[char] = (wordCount[char] || 0) + 1;
        }

        let canForm = true;
        for (const char in wordCount) {
            if (wordCount[char] > (charCount[char] || 0)) {
                canForm = false;
                break;
            }
        }

        if (canForm) {
            totalLength += word.length;
        }
    }

    return totalLength;
};