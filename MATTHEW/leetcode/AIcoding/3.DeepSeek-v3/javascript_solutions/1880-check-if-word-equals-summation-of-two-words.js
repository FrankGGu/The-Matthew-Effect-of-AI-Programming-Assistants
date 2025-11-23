var isSumEqual = function(firstWord, secondWord, targetWord) {
    const getNumericalValue = (word) => {
        let value = 0;
        for (const char of word) {
            value = value * 10 + (char.charCodeAt(0) - 'a'.charCodeAt(0));
        }
        return value;
    };

    const firstValue = getNumericalValue(firstWord);
    const secondValue = getNumericalValue(secondWord);
    const targetValue = getNumericalValue(targetWord);

    return firstValue + secondValue === targetValue;
};