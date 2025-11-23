var interchangeableRectangles = function(rectangles) {
    const ratios = new Map();
    let count = 0;

    for (const rect of rectangles) {
        const ratio = rect[0] / rect[1];
        if (ratios.has(ratio)) {
            count += ratios.get(ratio);
            ratios.set(ratio, ratios.get(ratio) + 1);
        } else {
            ratios.set(ratio, 1);
        }
    }

    return count;
};