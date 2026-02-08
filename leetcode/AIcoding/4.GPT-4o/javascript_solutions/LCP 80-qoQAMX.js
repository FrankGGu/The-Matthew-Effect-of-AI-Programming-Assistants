function isAlienSorted(words, order) {
    const orderMap = new Map();
    for (let i = 0; i < order.length; i++) {
        orderMap.set(order[i], i);
    }

    for (let i = 1; i < words.length; i++) {
        if (!isInOrder(words[i - 1], words[i], orderMap)) {
            return false;
        }
    }

    return true;
}

function isInOrder(word1, word2, orderMap) {
    const minLength = Math.min(word1.length, word2.length);
    for (let i = 0; i < minLength; i++) {
        const char1 = word1[i];
        const char2 = word2[i];
        if (char1 !== char2) {
            return orderMap.get(char1) < orderMap.get(char2);
        }
    }
    return word1.length <= word2.length;
}