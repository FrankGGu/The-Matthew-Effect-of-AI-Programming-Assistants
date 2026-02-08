var countGoodRectangles = function(rectangles) {
    let maxLen = 0;
    let count = 0;

    for (const [l, w] of rectangles) {
        const current = Math.min(l, w);
        if (current > maxLen) {
            maxLen = current;
            count = 1;
        } else if (current === maxLen) {
            count++;
        }
    }

    return count;
};