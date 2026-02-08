var isSumEqual = function(word1, word2, target) {
    const getValue = (word) => {
        let num = 0;
        for (let char of word) {
            num = num * 10 + (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        return num;
    };

    return getValue(word1) + getValue(word2) === getValue(target);
};