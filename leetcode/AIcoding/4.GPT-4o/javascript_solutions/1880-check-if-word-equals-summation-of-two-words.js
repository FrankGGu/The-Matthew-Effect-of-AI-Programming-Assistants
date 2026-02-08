var isSumEqual = function(firstWord, secondWord, targetWord) {
    const wordToNum = (word) => {
        return word.split('').reduce((num, char) => num * 10 + (char.charCodeAt(0) - 'a'.charCodeAt(0)), 0);
    };

    return wordToNum(firstWord) + wordToNum(secondWord) === wordToNum(targetWord);
};