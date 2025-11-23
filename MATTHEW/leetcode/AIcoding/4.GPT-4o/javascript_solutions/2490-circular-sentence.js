function isCircularSentence(sentence) {
    const words = sentence.split(' ');
    for (let i = 0; i < words.length; i++) {
        if (words[i][words[i].length - 1] !== words[(i + 1) % words.length][0]) {
            return false;
        }
    }
    return words[0][0] === words[words.length - 1][words[words.length - 1].length - 1];
}