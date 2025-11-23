var maxAreaRect = function(points) {
    const n = points.length;
    let maxArea = 0;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < n; j++) {
            if (points[i][0] >= points[j][0] || points[i][1] >= points[j][1]) {
                continue;
            }

            let rectArea = (points[j][0] - points[i][0]) * (points[j][1] - points[i][1]);
            let valid = true;

            for (let k = 0; k < n; k++) {
                if (points[k][0] > points[i][0] && points[k][0] < points[j][0] &&
                    points[k][1] > points[i][1] && points[k][1] < points[j][1]) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                maxArea = Math.max(maxArea, rectArea);
            }
        }
    }

    return maxArea;
};