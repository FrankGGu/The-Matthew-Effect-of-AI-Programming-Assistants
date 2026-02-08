var isSumEqual = function(firstWord, secondWord, targetWord) {
    const convertWordToValue = (word) => {
        let value = 0;
        for (let i = 0; i < word.length; i++) {
            const digit = word.charCodeAt(i) - 'a'.charCodeAt(0);
            value = value * 10 + digit;
        }
        return value;
    };

    const value1 = convertWordToValue(firstWord);
    const value2 = convertWordToValue(secondWord);
    const value3 = convertWordToValue(targetWord);

    return value1 + value2 === value3;
};