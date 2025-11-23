var areaOfMaxDiagonal = function(rectangles) {
    let maxDiagonalSq = 0;
    let maxArea = 0;

    for (let i = 0; i < rectangles.length; i++) {
        const l = rectangles[i][0];
        const w = rectangles[i][1];

        const currentDiagonalSq = l * l + w * w;
        const currentArea = l * w;

        if (currentDiagonalSq > maxDiagonalSq) {
            maxDiagonalSq = currentDiagonalSq;
            maxArea = currentArea;
        } else if (currentDiagonalSq === maxDiagonalSq) {
            if (currentArea > maxArea) {
                maxArea = currentArea;
            }
        }
    }

    return maxArea;
};