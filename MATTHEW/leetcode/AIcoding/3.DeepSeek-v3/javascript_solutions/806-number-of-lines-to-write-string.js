var numberOfLines = function(widths, s) {
    let lines = 1;
    let currentWidth = 0;
    for (let char of s) {
        const charWidth = widths[char.charCodeAt(0) - 'a'.charCodeAt(0)];
        if (currentWidth + charWidth > 100) {
            lines++;
            currentWidth = charWidth;
        } else {
            currentWidth += charWidth;
        }
    }
    return [lines, currentWidth];
};