var interchangeableRectangles = function(rectangles) {
    const ratioCount = new Map();
    let pairs = 0;

    for (const [width, height] of rectangles) {
        const gcd = getGCD(width, height);
        const ratio = `${width / gcd}-${height / gcd}`;
        if (ratioCount.has(ratio)) {
            pairs += ratioCount.get(ratio);
            ratioCount.set(ratio, ratioCount.get(ratio) + 1);
        } else {
            ratioCount.set(ratio, 1);
        }
    }

    return pairs;
};

function getGCD(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}