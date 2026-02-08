var findSubstring = function(s, words) {
    if (!s || !words || words.length === 0) {
        return [];
    }

    const wordLen = words[0].length;
    const numWords = words.length;
    const totalLen = wordLen * numWords;
    const result = [];

    if (s.length < totalLen) {
        return result;
    }

    const wordCountMap = new Map();
    for (const word of words) {
        wordCountMap.set(word, (wordCountMap.get(word) || 0) + 1);
    }

    for (let i = 0; i < wordLen; i++) {
        let currentWindowMap = new Map();
        let wordsFound = 0;
        let windowStart = i;

        for (let j = i; j <= s.length - wordLen; j += wordLen) {
            const currentWord = s.substring(j, j + wordLen);

            if (wordCountMap.has(currentWord)) {
                currentWindowMap.set(currentWord, (currentWindowMap.get(currentWord) || 0) + 1);
                wordsFound++;

                while (currentWindowMap.get(currentWord) > wordCountMap.get(currentWord)) {
                    const firstWordInWindow = s.substring(windowStart, windowStart + wordLen);
                    currentWindowMap.set(firstWordInWindow, currentWindowMap.get(firstWordInWindow) - 1);
                    wordsFound--;
                    windowStart += wordLen;
                }

                if (wordsFound === numWords) {
                    result.push(windowStart);

                    const firstWordInWindow = s.substring(windowStart, windowStart + wordLen);
                    currentWindowMap.set(firstWordInWindow, currentWindowMap.get(firstWordInWindow) - 1);
                    wordsFound--;
                    windowStart += wordLen;
                }
            } else {
                currentWindowMap.clear();
                wordsFound = 0;
                windowStart = j + wordLen;
            }
        }
    }

    return result;
};