function minAreaRect(rectangles) {
    const points = new Set();
    const xToYs = new Map();

    for (const [x, y] of rectangles) {
        const key = `${x},${y}`;
        points.add(key);
        if (!xToYs.has(x)) {
            xToYs.set(x, new Set());
        }
        xToYs.get(x).add(y);
    }

    let minArea = Infinity;

    for (const [x1, y1] of rectangles) {
        const ys1 = xToYs.get(x1);
        for (const [x2, y2] of rectangles) {
            if (x1 === x2) continue;
            const ys2 = xToYs.get(x2);
            if (ys1 && ys2) {
                const commonYs = new Set([...ys1].filter(y => ys2.has(y)));
                if (commonYs.size >= 2) {
                    const sortedYs = Array.from(commonYs).sort((a, b) => a - b);
                    for (let i = 0; i < sortedYs.length - 1; i++) {
                        const y3 = sortedYs[i];
                        const y4 = sortedYs[i + 1];
                        const area = Math.abs((x2 - x1) * (y4 - y3));
                        if (area < minArea) {
                            minArea = area;
                        }
                    }
                }
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
}