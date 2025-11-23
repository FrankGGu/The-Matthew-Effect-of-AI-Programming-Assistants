function gridIllumination(n, queries, hits) {
    const row = new Map();
    const col = new Map();
    const diag1 = new Map();
    const diag2 = new Map();
    const lights = new Set();

    for (const [x, y] of hits) {
        const key = `${x},${y}`;
        if (!lights.has(key)) {
            lights.add(key);
            row.set(x, (row.get(x) || 0) + 1);
            col.set(y, (col.get(y) || 0) + 1);
            diag1.set(x - y, (diag1.get(x - y) || 0) + 1);
            diag2.set(x + y, (diag2.get(x + y) || 0) + 1);
        }
    }

    const result = [];
    for (const [x, y] of queries) {
        const key = `${x},${y}`;
        if (row.has(x) || col.has(y) || diag1.has(x - y) || diag2.has(x + y)) {
            result.push(1);
        } else {
            result.push(0);
        }

        if (lights.has(key)) {
            lights.delete(key);
            row.set(x, row.get(x) - 1);
            if (row.get(x) === 0) row.delete(x);
            col.set(y, col.get(y) - 1);
            if (col.get(y) === 0) col.delete(y);
            diag1.set(x - y, diag1.get(x - y) - 1);
            if (diag1.get(x - y) === 0) diag1.delete(x - y);
            diag2.set(x + y, diag2.get(x + y) - 1);
            if (diag2.get(x + y) === 0) diag2.delete(x + y);
        }
    }

    return result;
}