var maxAreaRect = function(points) {
    let maxArea = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            if (points[i][0] === points[j][0] || points[i][1] === points[j][1]) {
                continue;
            }

            const x1 = Math.min(points[i][0], points[j][0]);
            const x2 = Math.max(points[i][0], points[j][0]);
            const y1 = Math.min(points[i][1], points[j][1]);
            const y2 = Math.max(points[i][1], points[j][1]);

            let found1 = false;
            let found2 = false;

            for (let k = 0; k < n; k++) {
                if (k !== i && k !== j) {
                    if (points[k][0] === x1 && points[k][1] === y2) {
                        found1 = true;
                    }
                    if (points[k][0] === x2 && points[k][1] === y1) {
                        found2 = true;
                    }
                }
            }

            if (found1 && found2) {
                maxArea = Math.max(maxArea, (x2 - x1) * (y2 - y1));
            }
        }
    }

    return maxArea;
};