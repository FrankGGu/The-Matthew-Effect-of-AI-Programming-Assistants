var findSubstring = function(s, words) {
    const result = [];
    if (!s || !words || words.length === 0) {
        return result;
    }

    const wordLen = words[0].length;
    const totalLen = wordLen * words.length;
    const wordCount = {};

    for (const word of words) {
        wordCount[word] = (wordCount[word] || 0) + 1;
    }

    for (let i = 0; i <= s.length - totalLen; i++) {
        const seenWords = {};
        let wordsFound = 0;

        for (let j = 0; j < words.length; j++) {
            const wordIndex = i + j * wordLen;
            const word = s.substring(wordIndex, wordIndex + wordLen);

            if (wordCount[word]) {
                seenWords[word] = (seenWords[word] || 0) + 1;
                if (seenWords[word] > wordCount[word]) {
                    break;
                }
                wordsFound++;
            } else {
                break;
            }
        }

        if (wordsFound === words.length) {
            result.push(i);
        }
    }

    return result;
};