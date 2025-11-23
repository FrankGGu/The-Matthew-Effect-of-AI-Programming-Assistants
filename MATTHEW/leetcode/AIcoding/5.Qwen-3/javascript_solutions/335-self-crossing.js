function isSelfCrossing(points) {
    const n = points.length;
    for (let i = 3; i < n; i++) {
        if (points[i][1] >= points[i - 1][1] && points[i][1] <= points[i - 2][1] &&
            points[i][0] >= points[i - 1][0] && points[i][0] <= points[i - 2][0]) {
            return true;
        }
        if (i >= 4) {
            if (points[i][1] === points[i - 2][1] && points[i][1] >= points[i - 3][1] &&
                points[i][0] >= points[i - 1][0] && points[i][0] <= points[i - 2][0]) {
                return true;
            }
        }
        if (i >= 5) {
            if (points[i][0] >= points[i - 3][0] && points[i][0] <= points[i - 2][0] &&
                points[i][1] >= points[i - 4][1] && points[i][1] <= points[i - 2][1] &&
                points[i - 1][0] >= points[i - 4][0] && points[i - 1][0] <= points[i - 3][0] &&
                points[i - 1][1] >= points[i - 5][1] && points[i - 1][1] <= points[i - 3][1]) {
                return true;
            }
        }
    }
    return false;
}