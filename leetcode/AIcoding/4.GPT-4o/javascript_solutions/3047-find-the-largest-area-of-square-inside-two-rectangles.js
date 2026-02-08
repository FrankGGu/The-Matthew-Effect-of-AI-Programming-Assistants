function maxSquare(rect1, rect2) {
    const [x1, y1, x2, y2] = rect1;
    const [x3, y3, x4, y4] = rect2;

    const left = Math.max(x1, x3);
    const right = Math.min(x2, x4);
    const bottom = Math.max(y1, y3);
    const top = Math.min(y2, y4);

    const width = right - left;
    const height = top - bottom;

    return Math.max(0, Math.min(width, height) ** 2);
}