var isAlienSorted = function(words, order) {
    const charRanks = new Array(26);
    for (let i = 0; i < order.length; i++) {
        charRanks[order.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    const compareWords = (word1, word2) => {
        const len1 = word1.length;
        const len2 = word2.length;
        const minLen = Math.min(len1, len2);

        for (let i = 0; i < minLen; i++) {
            const char1 = word1[i];
            const char2 = word2[i];

            const rank1 = charRanks[char1.charCodeAt(0) - 'a'.charCodeAt(0)];
            const rank2 = charRanks[char2.charCodeAt(0) - 'a'.charCodeAt(0)];

            if (rank1 < rank2) {
                return true;
            }
            if (rank1 > rank2) {
                return false;
            }
        }

        return len1 <= len2;
    };

    for (let i = 0; i < words.length - 1; i++) {
        if (!compareWords(words[i], words[i+1])) {
            return false;
        }
    }

    return true;
};