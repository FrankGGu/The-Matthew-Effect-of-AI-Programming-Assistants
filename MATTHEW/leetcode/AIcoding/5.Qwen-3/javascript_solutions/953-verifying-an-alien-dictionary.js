function isAlienSorted(words, order) {
    const orderMap = new Map();
    for (let i = 0; i < order.length; i++) {
        orderMap.set(order[i], i);
    }

    for (let i = 0; i < words.length - 1; i++) {
        const word1 = words[i];
        const word2 = words[i + 1];

        for (let j = 0; j < Math.min(word1.length, word2.length); j++) {
            const char1 = word1[j];
            const char2 = word2[j];

            if (char1 !== char2) {
                if (orderMap.get(char1) > orderMap.get(char2)) {
                    return false;
                }
                break;
            }
        }
    }

    return true;
}