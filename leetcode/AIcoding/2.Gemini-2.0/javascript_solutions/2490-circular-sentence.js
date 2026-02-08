var isCircularSentence = function(sentence) {
    const words = sentence.split(" ");
    if (words.length === 1) {
        return words[0][0] === words[0][words[0].length - 1];
    }
    for (let i = 0; i < words.length - 1; i++) {
        if (words[i][words[i].length - 1] !== words[i + 1][0]) {
            return false;
        }
    }
    return words[words.length - 1][words[words.length - 1].length - 1] === words[0][0];
};