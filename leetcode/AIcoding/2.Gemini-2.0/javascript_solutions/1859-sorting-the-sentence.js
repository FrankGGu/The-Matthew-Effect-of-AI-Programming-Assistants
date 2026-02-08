var sortSentence = function(s) {
    const words = s.split(" ");
    const sortedWords = new Array(words.length);
    for (const word of words) {
        const index = parseInt(word.slice(-1)) - 1;
        sortedWords[index] = word.slice(0, -1);
    }
    return sortedWords.join(" ");
};