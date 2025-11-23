var largestSquareArea = function(rectangles) {
    let maxArea = 0;
    const n = rectangles.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const [x1, y1, x2, y2] = rectangles[i];
            const [a1, b1, a2, b2] = rectangles[j];

            const xOverlap = Math.min(x2, a2) - Math.max(x1, a1);
            const yOverlap = Math.min(y2, b2) - Math.max(y1, b1);

            if (xOverlap > 0 && yOverlap > 0) {
                const side = Math.min(xOverlap, yOverlap);
                maxArea = Math.max(maxArea, side * side);
            }
        }
    }

    return maxArea;
};