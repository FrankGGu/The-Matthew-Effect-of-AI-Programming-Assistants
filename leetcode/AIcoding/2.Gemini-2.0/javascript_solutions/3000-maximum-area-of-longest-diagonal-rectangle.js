var areaOfMaxDiagonal = function(rectangles) {
    let maxDiagonal = 0;
    let maxArea = 0;

    for (const rect of rectangles) {
        const l = rect[0];
        const w = rect[1];
        const diagonal = Math.sqrt(l * l + w * w);
        const area = l * w;

        if (diagonal > maxDiagonal) {
            maxDiagonal = diagonal;
            maxArea = area;
        } else if (diagonal === maxDiagonal) {
            maxArea = Math.max(maxArea, area);
        }
    }

    return maxArea;
};