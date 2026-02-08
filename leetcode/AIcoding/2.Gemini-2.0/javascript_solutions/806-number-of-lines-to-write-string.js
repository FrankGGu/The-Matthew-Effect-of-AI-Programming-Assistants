var numberOfLines = function(widths, s) {
    let lines = 1;
    let currentWidth = 0;

    for (let i = 0; i < s.length; i++) {
        const width = widths[s.charCodeAt(i) - 'a'.charCodeAt(0)];
        if (currentWidth + width > 100) {
            lines++;
            currentWidth = width;
        } else {
            currentWidth += width;
        }
    }

    return [lines, currentWidth];
};