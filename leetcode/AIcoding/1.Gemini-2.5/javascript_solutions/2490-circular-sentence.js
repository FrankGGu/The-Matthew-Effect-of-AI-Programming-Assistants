var isCircularSentence = function(sentence) {
    const words = sentence.split(' ');
    const n = words.length;

    for (let i = 0; i < n - 1; i++) {
        if (words[i].at(-1) !== words[i + 1].at(0)) {
            return false;
        }
    }

    if (words[n - 1].at(-1) !== words[0].at(0)) {
        return false;
    }

    return true;
};