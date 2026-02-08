var countRectangles = function(rectangles, points) {
    const rectsByL = Array(101).fill(null).map(() => []);

    for (const [l, h] of rectangles) {
        rectsByL[l].push(h);
    }

    for (let i = 1; i <= 100; i++) {
        rectsByL[i].sort((a, b) => a - b);
    }

    const results = new Array(points.length);

    function lowerBound(arr, target) {
        let low = 0;
        let high = arr.length;
        while (low < high) {
            const mid = Math.floor((low + high) / 2);
            if (arr[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    for (let i = 0; i < points.length; i++) {
        const [px, py] = points[i];
        let count = 0;

        for (let l = px; l <= 100; l++) {
            const heights = rectsByL[l];
            const idx = lowerBound(heights, py);
            count += (heights.length - idx);
        }
        results[i] = count;
    }

    return results;
};