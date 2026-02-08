var findSubstring = function(s, words) {
    const wordLen = words[0].length;
    const numWords = words.length;
    const totalLen = wordLen * numWords;
    const wordCount = {};

    for (const word of words) {
        wordCount[word] = (wordCount[word] || 0) + 1;
    }

    const result = [];

    for (let i = 0; i <= s.length - totalLen; i++) {
        const seen = {};
        let j = 0;

        while (j < numWords) {
            const wordIndex = i + j * wordLen;
            const word = s.substring(wordIndex, wordIndex + wordLen);

            if (!wordCount[word]) break;
            seen[word] = (seen[word] || 0) + 1;

            if (seen[word] > wordCount[word]) break;
            j++;
        }

        if (j === numWords) result.push(i);
    }

    return result;
};