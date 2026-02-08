var countArtifacts = function(n, artifacts, dig) {
    const grid = Array(n).fill(0).map(() => Array(n).fill(0));

    for (const [r, c] of dig) {
        grid[r][c] = 1;
    }

    const prefixSum = Array(n + 1).fill(0).map(() => Array(n + 1).fill(0));

    for (let r = 0; r < n; r++) {
        for (let c = 0; c < n; c++) {
            prefixSum[r + 1][c + 1] = grid[r][c] + prefixSum[r][c + 1] + prefixSum[r + 1][c] - prefixSum[r][c];
        }
    }

    let extractedCount = 0;

    for (const [r1, c1, r2, c2] of artifacts) {
        const numCells = (r2 - r1 + 1) * (c2 - c1 + 1);

        const dugCells = prefixSum[r2 + 1][c2 + 1] - prefixSum[r1][c2 + 1] - prefixSum[r2 + 1][c1] + prefixSum[r1][c1];

        if (dugCells === numCells) {
            extractedCount++;
        }
    }

    return extractedCount;
};