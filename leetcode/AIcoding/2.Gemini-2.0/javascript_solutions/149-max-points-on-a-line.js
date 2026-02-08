var maxPoints = function(points) {
    if (points.length <= 2) {
        return points.length;
    }

    let max = 0;
    for (let i = 0; i < points.length; i++) {
        const slopeMap = new Map();
        let duplicates = 1;
        let vertical = 0;
        let currentMax = 0;

        for (let j = i + 1; j < points.length; j++) {
            const x1 = points[i][0];
            const y1 = points[i][1];
            const x2 = points[j][0];
            const y2 = points[j][1];

            if (x1 === x2 && y1 === y2) {
                duplicates++;
            } else if (x1 === x2) {
                vertical++;
            } else {
                const slope = (y2 - y1) / (x2 - x1);
                slopeMap.set(slope, (slopeMap.get(slope) || 0) + 1);
                currentMax = Math.max(currentMax, slopeMap.get(slope));
            }
        }

        currentMax = Math.max(currentMax, vertical);
        max = Math.max(max, currentMax + duplicates);
    }

    return max;
};