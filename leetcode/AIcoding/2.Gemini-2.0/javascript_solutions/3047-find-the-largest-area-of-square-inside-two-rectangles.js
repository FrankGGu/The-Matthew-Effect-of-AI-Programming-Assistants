var largestArea = function(rectangles) {
    let xOverlap = 0;
    let yOverlap = 0;

    let minRight = Infinity;
    let maxLeft = -Infinity;
    let minTop = Infinity;
    let maxBottom = -Infinity;

    for (const rect of rectangles) {
        maxLeft = Math.max(maxLeft, rect[0]);
        minRight = Math.min(minRight, rect[2]);
        maxBottom = Math.max(maxBottom, rect[1]);
        minTop = Math.min(minTop, rect[3]);
    }

    xOverlap = Math.max(0, minRight - maxLeft);
    yOverlap = Math.max(0, minTop - maxBottom);

    let side = Math.min(xOverlap, yOverlap);

    return BigInt(side) * BigInt(side);
};