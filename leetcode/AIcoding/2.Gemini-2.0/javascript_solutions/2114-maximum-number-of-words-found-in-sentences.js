var mostWordsFound = function(sentences) {
    let maxWords = 0;
    for (let i = 0; i < sentences.length; i++) {
        const words = sentences[i].split(" ");
        maxWords = Math.max(maxWords, words.length);
    }
    return maxWords;
};