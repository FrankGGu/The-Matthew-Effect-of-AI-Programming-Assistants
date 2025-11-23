var fullJustify = function(words, maxWidth) {
    const res = [];
    let currentLine = [];
    let numOfLetters = 0;

    for (let word of words) {
        if (numOfLetters + word.length + currentLine.length > maxWidth) {
            for (let i = 0; i < maxWidth - numOfLetters; i++) {
                currentLine[i % (currentLine.length - 1 || 1)] += ' ';
            }
            res.push(currentLine.join(''));
            currentLine = [];
            numOfLetters = 0;
        }
        currentLine.push(word);
        numOfLetters += word.length;
    }

    res.push(currentLine.join(' ') + ' '.repeat(maxWidth - numOfLetters - currentLine.length + 1));
    return res;
};