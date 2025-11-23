var countWords = function(words1, words2, letters) {
    const count = (words) => {
        const freq = {};
        for (const word of words) {
            const tempFreq = {};
            for (const char of word) {
                tempFreq[char] = (tempFreq[char] || 0) + 1;
            }
            if (Object.keys(tempFreq).every(k => (freq[k] = (freq[k] || 0) + tempFreq[k]) <= (letters[k] || 0))) {
                freq[word] = (freq[word] || 0) + 1;
            }
        }
        return Object.keys(freq).filter(word => freq[word] === 1).length;
    };

    const freqLetters = {};
    for (const char of letters) {
        freqLetters[char] = (freqLetters[char] || 0) + 1;
    }

    return countWords(words1) + countWords(words2);
};