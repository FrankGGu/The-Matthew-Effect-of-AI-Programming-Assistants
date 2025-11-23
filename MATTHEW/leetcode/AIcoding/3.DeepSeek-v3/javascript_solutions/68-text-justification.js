var fullJustify = function(words, maxWidth) {
    const result = [];
    let currentLine = [];
    let currentLength = 0;

    for (const word of words) {
        if (currentLength + word.length + currentLine.length > maxWidth) {
            const totalSpaces = maxWidth - currentLength;
            const gaps = currentLine.length - 1;

            if (gaps === 0) {
                result.push(currentLine[0] + ' '.repeat(totalSpaces));
            } else {
                const spacePerGap = Math.floor(totalSpaces / gaps);
                let extraSpaces = totalSpaces % gaps;
                let line = '';

                for (let i = 0; i < currentLine.length; i++) {
                    line += currentLine[i];
                    if (i < gaps) {
                        line += ' '.repeat(spacePerGap);
                        if (extraSpaces > 0) {
                            line += ' ';
                            extraSpaces--;
                        }
                    }
                }
                result.push(line);
            }

            currentLine = [];
            currentLength = 0;
        }

        currentLine.push(word);
        currentLength += word.length;
    }

    const lastLine = currentLine.join(' ');
    result.push(lastLine + ' '.repeat(maxWidth - lastLine.length));

    return result;
};