var numberOfLines = function(widths, S) {
    let lines = 1, currentWidth = 0;
    for (let char of S) {
        const charWidth = widths[char.charCodeAt() - 'a'.charCodeAt()];
        if (currentWidth + charWidth > 100) {
            lines++;
            currentWidth = charWidth;
        } else {
            currentWidth += charWidth;
        }
    }
    return [lines, currentWidth];
};