var fullJustify = function(words, maxWidth) {
    const result = [];
    let currentLine = [];
    let currentLength = 0;

    for (const word of words) {
        if (currentLength + currentLine.length + word.length > maxWidth) {
            if (currentLine.length === 1) {
                result.push(currentLine[0] + ' '.repeat(maxWidth - currentLength));
            } else {
                const spacesNeeded = maxWidth - currentLength;
                const spacesBetween = Math.floor(spacesNeeded / (currentLine.length - 1));
                const extraSpaces = spacesNeeded % (currentLine.length - 1);

                let line = '';
                for (let i = 0; i < currentLine.length - 1; i++) {
                    line += currentLine[i] + ' '.repeat(spacesBetween);
                    if (i < extraSpaces) {
                        line += ' ';
                    }
                }
                line += currentLine[currentLine.length - 1];
                result.push(line);
            }

            currentLine = [word];
            currentLength = word.length;
        } else {
            currentLine.push(word);
            currentLength += word.length;
        }
    }

    const lastLine = currentLine.join(' ') + ' '.repeat(maxWidth - currentLength - (currentLine.length - 1));
    result.push(lastLine);

    return result;
};