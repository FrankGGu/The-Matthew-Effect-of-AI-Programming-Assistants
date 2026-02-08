var countValidWords = function(sentence) {
    const tokens = sentence.split(/\s+/).filter(token => token.length > 0);
    let validWordCount = 0;

    function isValidWord(word) {
        let hyphenCount = 0;
        let punctuationCount = 0;
        const n = word.length;

        for (let i = 0; i < n; i++) {
            const char = word[i];

            if (char >= 'a' && char <= 'z') {
                continue;
            } else if (char === '-') {
                hyphenCount++;
                if (hyphenCount > 1 || i === 0 || i === n - 1 ||
                    !(word[i - 1] >= 'a' && word[i - 1] <= 'z') ||
                    !(word[i + 1] >= 'a' && word[i + 1] <= 'z')) {
                    return false;
                }
            } else if (char === '!' || char === '.' || char === ',') {
                punctuationCount++;
                if (punctuationCount > 1 || i !== n - 1) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }

    for (const word of tokens) {
        if (isValidWord(word)) {
            validWordCount++;
        }
    }

    return validWordCount;
};