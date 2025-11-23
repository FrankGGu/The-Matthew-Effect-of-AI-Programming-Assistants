var minimumLengthEncoding = function(words) {
    const uniqueWords = new Set(words);
    for (const word of words) {
        for (let i = 1; i < word.length; i++) {
            uniqueWords.delete(word.slice(i));
        }
    }
    let length = 0;
    for (const word of uniqueWords) {
        length += word.length + 1;
    }
    return length;
};