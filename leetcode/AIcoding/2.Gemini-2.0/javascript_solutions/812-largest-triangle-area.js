var largestTriangleArea = function(points) {
    let maxArea = 0;
    for (let i = 0; i < points.length; i++) {
        for (let j = i + 1; j < points.length; j++) {
            for (let k = j + 1; k < points.length; k++) {
                let area = 0.5 * Math.abs(points[i][0] * (points[j][1] - points[k][1]) +
                                           points[j][0] * (points[k][1] - points[i][1]) +
                                           points[k][0] * (points[i][1] - points[j][1]));
                maxArea = Math.max(maxArea, area);
            }
        }
    }
    return maxArea;
};