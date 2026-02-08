var isCircularSentence = function(sentence) {
    const words = sentence.split(' ');
    const n = words.length;
    if (words[0][0] !== words[n - 1][words[n - 1].length - 1]) {
        return false;
    }
    for (let i = 0; i < n - 1; i++) {
        const current = words[i];
        const next = words[i + 1];
        if (current[current.length - 1] !== next[0]) {
            return false;
        }
    }
    return true;
};