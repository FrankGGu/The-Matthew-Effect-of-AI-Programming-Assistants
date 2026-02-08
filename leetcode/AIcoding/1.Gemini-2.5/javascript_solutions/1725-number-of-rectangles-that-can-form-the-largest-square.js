var countGoodRectangles = function(rectangles) {
    let maxSqSide = 0;
    for (let i = 0; i < rectangles.length; i++) {
        const currentSqSide = Math.min(rectangles[i][0], rectangles[i][1]);
        if (currentSqSide > maxSqSide) {
            maxSqSide = currentSqSide;
        }
    }

    let count = 0;
    for (let i = 0; i < rectangles.length; i++) {
        const currentSqSide = Math.min(rectangles[i][0], rectangles[i][1]);
        if (currentSqSide === maxSqSide) {
            count++;
        }
    }

    return count;
};