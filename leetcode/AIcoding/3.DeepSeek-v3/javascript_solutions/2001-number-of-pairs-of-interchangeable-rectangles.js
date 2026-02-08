var interchangeableRectangles = function(rectangles) {
    const ratioCount = new Map();
    let pairs = 0;

    for (const [w, h] of rectangles) {
        const ratio = w / h;
        if (ratioCount.has(ratio)) {
            const count = ratioCount.get(ratio);
            pairs += count;
            ratioCount.set(ratio, count + 1);
        } else {
            ratioCount.set(ratio, 1);
        }
    }

    return pairs;
};