var isAlienSorted = function(words, order) {
    const orderMap = new Array(26);
    for (let i = 0; i < order.length; i++) {
        orderMap[order.charCodeAt(i) - 'a'.charCodeAt(0)] = i;
    }

    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];

        let foundDifference = false;
        for (let j = 0; j < Math.min(word1.length, word2.length); j++) {
            const char1Rank = orderMap[word1.charCodeAt(j) - 'a'.charCodeAt(0)];
            const char2Rank = orderMap[word2.charCodeAt(j) - 'a'.charCodeAt(0)];

            if (char1Rank > char2Rank) {
                return false;
            }
            if (char1Rank < char2Rank) {
                foundDifference = true;
                break;
            }
        }

        if (!foundDifference && word1.length > word2.length) {
            return false;
        }
    }

    return true;
};