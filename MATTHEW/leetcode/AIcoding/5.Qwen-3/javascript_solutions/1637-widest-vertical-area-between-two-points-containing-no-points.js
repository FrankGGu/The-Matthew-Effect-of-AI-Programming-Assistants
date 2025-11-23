var maxWidthOfVerticalArea = function(points) {
    const sortedX = points.map(p => p[0]).sort((a, b) => a - b);
    let max = 0;
    for (let i = 1; i < sortedX.length; i++) {
        max = Math.max(max, sortedX[i] - sortedX[i - 1]);
    }
    return max;
};