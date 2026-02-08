var wordSubsets = function(words1, words2) {
    const countChars = (word) => {
        const freq = new Array(26).fill(0);
        for (let i = 0; i < word.length; i++) {
            freq[word.charCodeAt(i) - 'a'.charCodeAt(0)]++;
        }
        return freq;
    };

    const maxFreqB = new Array(26).fill(0);

    for (const word2 of words2) {
        const currentFreqB = countChars(word2);
        for (let i = 0; i < 26; i++) {
            maxFreqB[i] = Math.max(maxFreqB[i], currentFreqB[i]);
        }
    }

    const result = [];

    for (const word1 of words1) {
        const currentFreqA = countChars(word1);
        let isUniversal = true;
        for (let i = 0; i < 26; i++) {
            if (currentFreqA[i] < maxFreqB[i]) {
                isUniversal = false;
                break;
            }
        }
        if (isUniversal) {
            result.push(word1);
        }
    }

    return result;
};