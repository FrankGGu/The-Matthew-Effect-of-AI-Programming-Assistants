var isAlienSorted = function(words, order) {
    const orderMap = new Map();
    for (let i = 0; i < order.length; i++) {
        orderMap.set(order[i], i);
    }

    const compare = (word1, word2) => {
        const len = Math.min(word1.length, word2.length);
        for (let i = 0; i < len; i++) {
            if (word1[i] !== word2[i]) {
                return orderMap.get(word1[i]) - orderMap.get(word2[i]);
            }
        }
        return word1.length - word2.length;
    };

    for (let i = 1; i < words.length; i++) {
        if (compare(words[i - 1], words[i]) > 0) {
            return false;
        }
    }
    return true;
};