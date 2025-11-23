var minimumLengthEncoding = function(words) {
    const uniqueWords = new Set(words);
    for (let word of words) {
        for (let i = 1; i < word.length; i++) {
            uniqueWords.delete(word.slice(i));
        }
    }
    return Array.from(uniqueWords).reduce((acc, word) => acc + word.length + 1, 0);
};