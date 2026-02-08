var numberOfLines = function(widths, s) {
    let lines = 1;
    let currentLinePixels = 0;
    const maxLinePixels = 100;

    for (let i = 0; i < s.length; i++) {
        const charCode = s.charCodeAt(i) - 'a'.charCodeAt(0);
        const charWidth = widths[charCode];

        if (currentLinePixels + charWidth > maxLinePixels) {
            lines++;
            currentLinePixels = charWidth;
        } else {
            currentLinePixels += charWidth;
        }
    }

    return [lines, currentLinePixels];
};