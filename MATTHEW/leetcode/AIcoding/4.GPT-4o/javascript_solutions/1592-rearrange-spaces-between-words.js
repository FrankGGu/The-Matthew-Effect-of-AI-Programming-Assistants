var rearrangeSpaces = function(text) {
    const words = text.split(/\s+/).filter(Boolean);
    const spaces = text.length - words.join('').length;
    if (words.length === 1) return words[0] + ' '.repeat(spaces);

    const spaceBetweenWords = Math.floor(spaces / (words.length - 1));
    const extraSpaces = spaces % (words.length - 1);

    return words.join(' '.repeat(spaceBetweenWords)) + ' '.repeat(extraSpaces);
};