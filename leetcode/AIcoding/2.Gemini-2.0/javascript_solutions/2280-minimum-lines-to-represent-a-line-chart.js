var minimumLines = function(points) {
    if (points.length <= 1) return 0;

    points.sort((a, b) => a[0] - b[0]);

    let count = 1;
    for (let i = 2; i < points.length; i++) {
        let slope1 = (points[i - 1][1] - points[i - 2][1]) / (points[i - 1][0] - points[i - 2][0]);
        let slope2 = (points[i][1] - points[i - 1][1]) / (points[i][0] - points[i - 1][0]);

        if (slope1 !== slope2) {
            count++;
        }
    }

    return count;
};