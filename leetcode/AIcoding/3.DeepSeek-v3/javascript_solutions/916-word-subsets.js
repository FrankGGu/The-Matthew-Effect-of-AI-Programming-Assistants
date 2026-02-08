var wordSubsets = function(words1, words2) {
    const countLetters = (word) => {
        const count = new Array(26).fill(0);
        for (const c of word) {
            count[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
        return count;
    };

    const maxCount = new Array(26).fill(0);
    for (const word of words2) {
        const currentCount = countLetters(word);
        for (let i = 0; i < 26; i++) {
            maxCount[i] = Math.max(maxCount[i], currentCount[i]);
        }
    }

    const result = [];
    for (const word of words1) {
        const currentCount = countLetters(word);
        let isUniversal = true;
        for (let i = 0; i < 26; i++) {
            if (currentCount[i] < maxCount[i]) {
                isUniversal = false;
                break;
            }
        }
        if (isUniversal) {
            result.push(word);
        }
    }

    return result;
};