var countRectangles = function(rectangles, points) {
    rectangles.sort((a, b) => a[0] - b[0]);
    const result = [];

    for (const [x, y] of points) {
        let count = 0;
        for (const [l, h] of rectangles) {
            if (l >= x && h >= y) {
                count++;
            }
        }
        result.push(count);
    }

    return result;
};