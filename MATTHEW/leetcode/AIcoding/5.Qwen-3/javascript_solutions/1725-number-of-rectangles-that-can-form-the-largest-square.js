function countLargestRectangles(rectangles) {
    const maxSquare = {};
    for (const [width, height] of rectangles) {
        const side = Math.min(width, height);
        maxSquare[side] = (maxSquare[side] || 0) + 1;
    }
    let maxSide = 0;
    for (const side in maxSquare) {
        if (parseInt(side) > maxSide) {
            maxSide = parseInt(side);
        }
    }
    return maxSquare[maxSide];
}