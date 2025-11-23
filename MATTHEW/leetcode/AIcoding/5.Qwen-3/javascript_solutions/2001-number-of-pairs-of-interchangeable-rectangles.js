function interchangeableRectangles(rectangles) {
    const ratioMap = new Map();
    let result = 0;

    for (const [width, height] of rectangles) {
        const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
        const g = gcd(width, height);
        const key = `${width / g},${height / g}`;
        ratioMap.set(key, (ratioMap.get(key) || 0) + 1);
    }

    for (const count of ratioMap.values()) {
        if (count >= 2) {
            result += (count * (count - 1)) / 2;
        }
    }

    return result;
}