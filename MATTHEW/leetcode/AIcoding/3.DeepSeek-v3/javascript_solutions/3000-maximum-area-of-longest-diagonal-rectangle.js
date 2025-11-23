var areaOfMaxDiagonal = function(dimensions) {
    let maxDiagonal = 0;
    let maxArea = 0;

    for (const [l, w] of dimensions) {
        const diagonal = l * l + w * w;
        if (diagonal > maxDiagonal) {
            maxDiagonal = diagonal;
            maxArea = l * w;
        } else if (diagonal === maxDiagonal) {
            maxArea = Math.max(maxArea, l * w);
        }
    }

    return maxArea;
};