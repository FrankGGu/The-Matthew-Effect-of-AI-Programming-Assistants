var gridIllumination = function(n, lamps, queries) {
    const rowMap = new Map();
    const colMap = new Map();
    const diag1Map = new Map();
    const diag2Map = new Map();
    const lampSet = new Set();

    for (const [x, y] of lamps) {
        const key = `${x},${y}`;
        if (lampSet.has(key)) continue;
        lampSet.add(key);
        rowMap.set(x, (rowMap.get(x) || 0) + 1);
        colMap.set(y, (colMap.get(y) || 0) + 1);
        diag1Map.set(x - y, (diag1Map.get(x - y) || 0) + 1);
        diag2Map.set(x + y, (diag2Map.get(x + y) || 0) + 1);
    }

    const directions = [[-1, -1], [-1, 0], [-1, 1], [0, -1], [0, 0], [0, 1], [1, -1], [1, 0], [1, 1]];
    const result = [];

    for (const [x, y] of queries) {
        if (rowMap.get(x) > 0 || colMap.get(y) > 0 || diag1Map.get(x - y) > 0 || diag2Map.get(x + y) > 0) {
            result.push(1);
        } else {
            result.push(0);
        }

        for (const [dx, dy] of directions) {
            const nx = x + dx;
            const ny = y + dy;
            const key = `${nx},${ny}`;
            if (nx >= 0 && nx < n && ny >= 0 && ny < n && lampSet.has(key)) {
                lampSet.delete(key);
                rowMap.set(nx, rowMap.get(nx) - 1);
                colMap.set(ny, colMap.get(ny) - 1);
                diag1Map.set(nx - ny, diag1Map.get(nx - ny) - 1);
                diag2Map.set(nx + ny, diag2Map.get(nx + ny) - 1);
            }
        }
    }

    return result;
};