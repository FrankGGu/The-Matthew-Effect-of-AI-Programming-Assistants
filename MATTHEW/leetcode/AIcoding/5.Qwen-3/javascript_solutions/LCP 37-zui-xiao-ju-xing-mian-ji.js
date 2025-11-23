function minAreaRect(image) {
    const rows = image.length;
    const cols = image[0].length;
    const points = [];

    for (let i = 0; i < rows; i++) {
        for (let j = 0; j < cols; j++) {
            if (image[i][j] === 1) {
                points.push([i, j]);
            }
        }
    }

    points.sort((a, b) => a[0] !== b[0] ? a[0] - b[0] : a[1] - b[1]);

    const map = new Map();

    for (const [x, y] of points) {
        if (!map.has(x)) {
            map.set(x, []);
        }
        map.get(x).push(y);
    }

    let minArea = Infinity;

    for (const [x1, y1] of points) {
        const ys1 = map.get(x1);
        for (const [x2, y2] of points) {
            if (x1 === x2) continue;
            const ys2 = map.get(x2);
            const commonYs = ys1.filter(y => ys2.includes(y));
            if (commonYs.length >= 2) {
                const minY = Math.min(...commonYs);
                const maxY = Math.max(...commonYs);
                minArea = Math.min(minArea, (x2 - x1) * (maxY - minY));
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
}