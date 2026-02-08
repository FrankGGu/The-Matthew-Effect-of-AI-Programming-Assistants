var longestVShapedDiagonalSegment = function(points) {
    if (points.length < 3) {
        return 0;
    }

    const mainDiagonals = new Map();
    const antiDiagonals = new Map();

    for (const [x, y] of points) {
        const k1 = x - y;
        const k2 = x + y;

        if (!mainDiagonals.has(k1)) {
            mainDiagonals.set(k1, [x, x]);
        } else {
            const [minX, maxX] = mainDiagonals.get(k1);
            mainDiagonals.set(k1, [Math.min(minX, x), Math.max(maxX, x)]);
        }

        if (!antiDiagonals.has(k2)) {
            antiDiagonals.set(k2, [x, x]);
        } else {
            const [minX, maxX] = antiDiagonals.get(k2);
            antiDiagonals.set(k2, [Math.min(minX, x), Math.max(maxX, x)]);
        }
    }

    let maxLen = 0;

    for (const [x, y] of points) {
        const k1 = x - y;
        const k2 = x + y;

        const [minX_k1, maxX_k1] = mainDiagonals.get(k1);
        const [minX_k2, maxX_k2] = antiDiagonals.get(k2);

        let lenMainPart = 0;
        if (minX_k1 !== maxX_k1) {
            lenMainPart = Math.max(x - minX_k1, maxX_k1 - x);
        }

        let lenAntiPart = 0;
        if (minX_k2 !== maxX_k2) {
            lenAntiPart = Math.max(x - minX_k2, maxX_k2 - x);
        }

        if (lenMainPart > 0 && lenAntiPart > 0) {
            maxLen = Math.max(maxLen, lenMainPart + lenAntiPart);
        }
    }

    return maxLen;
};