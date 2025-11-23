var numberOfPairs = function(points) {
    points.sort((a, b) => a[0] - b[0] || a[1] - b[1]);
    let count = 0;
    const n = points.length;

    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const [x1, y1] = points[i];
            const [x2, y2] = points[j];
            let valid = true;

            for (let k = 0; k < n; k++) {
                if (k === i || k === j) continue;
                const [x, y] = points[k];
                if (x >= x1 && x <= x2 && y >= Math.min(y1, y2) && y <= Math.max(y1, y2)) {
                    valid = false;
                    break;
                }
            }

            if (valid) {
                count++;
            }
        }
    }

    return count;
};