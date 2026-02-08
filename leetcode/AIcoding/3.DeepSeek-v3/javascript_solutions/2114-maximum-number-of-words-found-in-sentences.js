var mostWordsFound = function(sentences) {
    let maxWords = 0;
    for (const sentence of sentences) {
        const words = sentence.split(' ').length;
        if (words > maxWords) {
            maxWords = words;
        }
    }
    return maxWords;
};