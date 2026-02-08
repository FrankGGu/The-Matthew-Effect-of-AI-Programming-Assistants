var isPrintable = function (paint) {
    const n = paint.length, m = paint[0].length;
    const minRow = Array(61).fill(Infinity), maxRow = Array(61).fill(-1);
    const minCol = Array(61).fill(Infinity), maxCol = Array(61).fill(-1);

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < m; j++) {
            const color = paint[i][j];
            if (color !== 0) {
                minRow[color] = Math.min(minRow[color], i);
                maxRow[color] = Math.max(maxRow[color], i);
                minCol[color] = Math.min(minCol[color], j);
                maxCol[color] = Math.max(maxCol[color], j);
            }
        }
    }

    const visited = new Array(61).fill(false);

    const canPrint = (color) => {
        if (visited[color]) return true;
        visited[color] = true;

        const r1 = minRow[color], r2 = maxRow[color];
        const c1 = minCol[color], c2 = maxCol[color];

        for (let i = r1; i <= r2; i++) {
            for (let j = c1; j <= c2; j++) {
                if (paint[i][j] !== color) {
                    if (paint[i][j] !== 0) return false;
                }
            }
        }

        for (let i = r1; i <= r2; i++) {
            for (let j = c1; j <= c2; j++) {
                if (paint[i][j] !== 0) {
                    if (!canPrint(paint[i][j])) return false;
                }
            }
        }

        return true;
    };

    for (let i = 1; i <= 60; i++) {
        if (minRow[i] !== Infinity && !canPrint(i)) {
            return false;
        }
    }

    return true;
};