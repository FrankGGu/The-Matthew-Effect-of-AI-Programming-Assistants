var numberOfPairs = function(points) {
    points.sort((a, b) => {
        if (a[0] !== b[0]) {
            return a[0] - b[0];
        } else {
            return b[1] - a[1];
        }
    });

    let count = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        const [x1, y1] = points[i];
        let maxY = -Infinity;

        for (let j = i + 1; j < n; j++) {
            const [x2, y2] = points[j];

            if (y2 > y1) continue;

            if (y2 > maxY) {
                count++;
                maxY = y2;
            }
        }
    }

    return count;
};