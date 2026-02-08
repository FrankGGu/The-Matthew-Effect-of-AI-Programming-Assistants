var reorderSpaces = function(text) {
    let words = text.trim().split(/\s+/);
    let spaceCount = 0;
    for (let c of text) {
        if (c === ' ') spaceCount++;
    }
    if (words.length === 1) {
        return words[0] + ' '.repeat(spaceCount);
    }
    let gap = Math.floor(spaceCount / (words.length - 1));
    let remaining = spaceCount % (words.length - 1);
    return words.join(' '.repeat(gap)) + ' '.repeat(remaining);
};