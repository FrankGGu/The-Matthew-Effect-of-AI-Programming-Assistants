var sortSentence = function(s) {
    const words = s.split(' ');
    const result = new Array(words.length);

    for (let i = 0; i < words.length; i++) {
        const word = words[i];
        const position = parseInt(word[word.length - 1]) - 1;
        const actualWord = word.substring(0, word.length - 1);
        result[position] = actualWord;
    }

    return result.join(' ');
};