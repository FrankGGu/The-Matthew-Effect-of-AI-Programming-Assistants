function isPrintable(targetGrid) {
    const N = targetGrid.length;
    const M = targetGrid[0].length;

    const bounds = Array(61).fill(null).map(() => [Infinity, Infinity, -Infinity, -Infinity]);
    const uniqueColors = new Set();

    for (let r = 0; r < N; r++) {
        for (let c = 0; c < M; c++) {
            const color = targetGrid[r][c];
            uniqueColors.add(color);
            bounds[color][0] = Math.min(bounds[color][0], r);
            bounds[color][1] = Math.min(bounds[color][1], c);
            bounds[color][2] = Math.max(bounds[color][2], r);
            bounds[color][3] = Math.max(bounds[color][3], c);
        }
    }

    const adj = Array(61).fill(0).map(() => new Set());
    const inDegree = Array(61).fill(0);

    for (const c of uniqueColors) {
        const [r1, c1, r2, c2] = bounds[c];
        for (let r = r1; r <= r2; r++) {
            for (let k = c1; k <= c2; k++) {
                const cellColor = targetGrid[r][k];
                if (cellColor !== c) {
                    if (!adj[cellColor].has(c)) {
                        adj[cellColor].add(c);
                        inDegree[c]++;
                    }
                }
            }
        }
    }

    const q = [];
    for (const c of uniqueColors) {
        if (inDegree[c] === 0) {
            q.push(c);
        }
    }

    let printedCount = 0;
    while (q.length > 0) {
        const u = q.shift();
        printedCount++;

        for (const v of adj[u]) {
            inDegree[v]--;
            if (inDegree[v] === 0) {
                q.push(v);
            }
        }
    }

    return printedCount === uniqueColors.size;
}