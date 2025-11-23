var isSumEqual = function(firstWord, secondWord, targetWord) {
    const getValue = (word) => {
        let value = 0;
        for (let i = 0; i < word.length; i++) {
            value = value * 10 + (word.charCodeAt(i) - 'a'.charCodeAt(0));
        }
        return value;
    }

    return getValue(firstWord) + getValue(secondWord) === getValue(targetWord);
};