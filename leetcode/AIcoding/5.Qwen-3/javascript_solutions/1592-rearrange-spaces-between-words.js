function reorderSpaces(text, numberOfSpaces) {
    const words = text.trim().split(/\s+/);
    const totalSpaces = text.length - text.replace(/\s+/g, '').length;
    const spaceBetween = Math.max(1, Math.floor(totalSpaces / (words.length - 1)));
    const extraSpaces = totalSpaces - (spaceBetween * (words.length - 1));

    if (words.length === 1) {
        return words[0] + ' '.repeat(totalSpaces);
    }

    const spaceStr = ' '.repeat(spaceBetween);
    let result = words.join(spaceStr);
    result += ' '.repeat(extraSpaces);

    return result;
}