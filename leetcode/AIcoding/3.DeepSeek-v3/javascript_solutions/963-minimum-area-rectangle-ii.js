var minAreaFreeRect = function(points) {
    const n = points.length;
    const map = new Map();
    for (let i = 0; i < n; i++) {
        for (let j = i + 1; j < n; j++) {
            const x1 = points[i][0], y1 = points[i][1];
            const x2 = points[j][0], y2 = points[j][1];
            const centerX = x1 + x2;
            const centerY = y1 + y2;
            const len = (x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2);
            const key = `${centerX},${centerY},${len}`;
            if (!map.has(key)) {
                map.set(key, []);
            }
            map.get(key).push([i, j]);
        }
    }

    let minArea = Infinity;
    for (const [key, pairs] of map) {
        if (pairs.length < 2) continue;
        for (let i = 0; i < pairs.length; i++) {
            for (let j = i + 1; j < pairs.length; j++) {
                const [a, b] = pairs[i];
                const [c, d] = pairs[j];
                const p1 = points[a];
                const p2 = points[b];
                const p3 = points[c];
                const v1 = [p1[0] - p3[0], p1[1] - p3[1]];
                const v2 = [p2[0] - p3[0], p2[1] - p3[1]];
                const dot = v1[0] * v2[0] + v1[1] * v2[1];
                if (Math.abs(dot) > 1e-7) continue;
                const area = Math.sqrt((v1[0] * v1[0] + v1[1] * v1[1]) * (v2[0] * v2[0] + v2[1] * v2[1]));
                if (area < minArea) {
                    minArea = area;
                }
            }
        }
    }
    return minArea === Infinity ? 0 : minArea;
};