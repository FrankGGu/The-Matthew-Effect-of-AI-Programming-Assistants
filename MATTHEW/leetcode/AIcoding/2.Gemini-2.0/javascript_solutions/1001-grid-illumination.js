var gridIllumination = function(n, lamps, queries) {
    const row = new Map();
    const col = new Map();
    const diag1 = new Map();
    const diag2 = new Map();
    const lampSet = new Set();

    for (const [r, c] of lamps) {
        const key = r * n + c;
        if (lampSet.has(key)) continue;
        lampSet.add(key);

        row.set(r, (row.get(r) || 0) + 1);
        col.set(c, (col.get(c) || 0) + 1);
        diag1.set(r - c, (diag1.get(r - c) || 0) + 1);
        diag2.set(r + c, (diag2.get(r + c) || 0) + 1);
    }

    const result = [];
    for (const [r, c] of queries) {
        if (row.get(r) || col.get(c) || diag1.get(r - c) || diag2.get(r + c)) {
            result.push(1);
        } else {
            result.push(0);
        }

        for (let i = -1; i <= 1; i++) {
            for (let j = -1; j <= 1; j++) {
                const nr = r + i;
                const nc = c + j;
                if (nr >= 0 && nr < n && nc >= 0 && nc < n) {
                    const key = nr * n + nc;
                    if (lampSet.has(key)) {
                        lampSet.delete(key);
                        row.set(nr, row.get(nr) - 1);
                        if (row.get(nr) === 0) row.delete(nr);
                        col.set(nc, col.get(nc) - 1);
                        if (col.get(nc) === 0) col.delete(nc);
                        diag1.set(nr - nc, diag1.get(nr - nc) - 1);
                        if (diag1.get(nr - nc) === 0) diag1.delete(nr - nc);
                        diag2.set(nr + nc, diag2.get(nr + nc) - 1);
                        if (diag2.get(nr + nc) === 0) diag2.delete(nr + nc);
                    }
                }
            }
        }
    }

    return result;
};