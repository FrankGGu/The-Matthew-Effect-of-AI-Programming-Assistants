var countGoodRectangles = function(rectangles) {
    let maxLength = 0;
    let count = 0;

    for (const [l, w] of rectangles) {
        const side = Math.min(l, w);
        if (side > maxLength) {
            maxLength = side;
            count = 1;
        } else if (side === maxLength) {
            count++;
        }
    }

    return count;
};