var maxPoints = function(points, r) {
    const n = points.length;
    let maxCount = 0;

    for (let i = 0; i < n; i++) {
        let count = 0;
        const [x1, y1] = points[i];

        for (let j = 0; j < n; j++) {
            const [x2, y2] = points[j];
            if (x2 >= x1 && x2 <= x1 + r && y2 >= y1 && y2 <= y1 + r) {
                count++;
            }
        }

        maxCount = Math.max(maxCount, count);
    }

    return maxCount;
};