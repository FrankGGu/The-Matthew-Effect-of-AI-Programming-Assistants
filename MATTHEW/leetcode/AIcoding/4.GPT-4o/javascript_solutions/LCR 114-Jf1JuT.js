var isAlienSorted = function(words, order) {
    const orderMap = new Map();
    for (let i = 0; i < order.length; i++) {
        orderMap.set(order[i], i);
    }

    for (let i = 0; i < words.length - 1; i++) {
        if (!isInOrder(words[i], words[i + 1], orderMap)) {
            return false;
        }
    }
    return true;
};

function isInOrder(word1, word2, orderMap) {
    const len1 = word1.length;
    const len2 = word2.length;
    const minLength = Math.min(len1, len2);

    for (let i = 0; i < minLength; i++) {
        if (orderMap.get(word1[i]) < orderMap.get(word2[i])) {
            return true;
        } else if (orderMap.get(word1[i]) > orderMap.get(word2[i])) {
            return false;
        }
    }

    return len1 <= len2;
}