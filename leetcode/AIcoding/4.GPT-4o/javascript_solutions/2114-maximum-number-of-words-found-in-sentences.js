var mostWordsFound = function(sentences) {
    let maxWords = 0;
    for (let sentence of sentences) {
        const wordCount = sentence.split(' ').length;
        maxWords = Math.max(maxWords, wordCount);
    }
    return maxWords;
};