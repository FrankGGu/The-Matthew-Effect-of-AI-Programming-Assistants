var countRectangles = function(rectangles, points) {
    const maxY = 100;
    const buckets = Array.from({ length: maxY + 1 }, () => []);

    for (const [x, y] of rectangles) {
        buckets[y].push(x);
    }

    for (let y = 1; y <= maxY; y++) {
        buckets[y].sort((a, b) => a - b);
    }

    const result = [];
    for (const [px, py] of points) {
        let count = 0;
        for (let y = py; y <= maxY; y++) {
            const xs = buckets[y];
            let left = 0, right = xs.length;
            while (left < right) {
                const mid = Math.floor((left + right) / 2);
                if (xs[mid] >= px) {
                    right = mid;
                } else {
                    left = mid + 1;
                }
            }
            count += xs.length - left;
        }
        result.push(count);
    }

    return result;
};