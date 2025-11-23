var printWordsVertically = function(words) {
    if (words.length === 0) return [];
    let maxLen = 0;
    for (let word of words) {
        maxLen = Math.max(maxLen, word.length);
    }
    let result = [];
    for (let i = 0; i < maxLen; i++) {
        let verticalWord = '';
        for (let j = 0; j < words.length; j++) {
            if (i < words[j].length) {
                verticalWord += words[j][i];
            } else {
                verticalWord += ' ';
            }
        }
        result.push(verticalWord.trimEnd());
    }
    return result;
};