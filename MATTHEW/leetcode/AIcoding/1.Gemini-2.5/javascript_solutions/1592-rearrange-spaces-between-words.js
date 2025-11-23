var reorderSpaces = function(text) {
    let spaceCount = 0;
    for (let i = 0; i < text.length; i++) {
        if (text[i] === ' ') {
            spaceCount++;
        }
    }

    const words = text.split(' ').filter(word => word.length > 0);
    const numWords = words.length;

    if (numWords === 0) {
        return ' '.repeat(spaceCount);
    }

    if (numWords === 1) {
        return words[0] + ' '.repeat(spaceCount);
    }

    const numGaps = numWords - 1;
    const spacesPerGap = Math.floor(spaceCount / numGaps);
    const extraSpaces = spaceCount % numGaps;

    const gapString = ' '.repeat(spacesPerGap);
    const result = words.join(gapString);

    return result + ' '.repeat(extraSpaces);
};