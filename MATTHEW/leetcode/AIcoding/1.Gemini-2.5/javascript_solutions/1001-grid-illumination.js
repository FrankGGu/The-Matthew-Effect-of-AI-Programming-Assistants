var gridIllumination = function(n, lamps, queries) {
    const rowCounts = new Map();
    const colCounts = new Map();
    const diag1Counts = new Map(); // r - c
    const diag2Counts = new Map(); // r + c
    const lampLocations = new Map(); // "r,c" -> count of lamps at this location

    for (const [r, c] of lamps) {
        const key = `${r},${c}`;
        if (!lampLocations.has(key)) { // Only increment counts if this is a new unique lamp location
            rowCounts.set(r, (rowCounts.get(r) || 0) + 1);
            colCounts.set(c, (colCounts.get(c) || 0) + 1);
            diag1Counts.set(r - c, (diag1Counts.get(r - c) || 0) + 1);
            diag2Counts.set(r + c, (diag2Counts.get(r + c) || 0) + 1);
        }
        lampLocations.set(key, (lampLocations.get(key) || 0) + 1);
    }

    const results = [];
    const neighbors = [
        [-1, -1], [-1, 0], [-1, 1],
        [0, -1], [0, 0], [0, 1],
        [1, -1], [1, 0], [1, 1]
    ];

    for (const [qr, qc] of queries) {
        let isIlluminated = false;

        if (rowCounts.get(qr) > 0 ||
            colCounts.get(qc) > 0 ||
            diag1Counts.get(qr - qc) > 0 ||
            diag2Counts.get(qr + qc) > 0) {
            isIlluminated = true;
        }
        results.push(isIlluminated ? 1 : 0);

        for (const [dr, dc] of neighbors) {
            const nr = qr + dr;
            const nc = qc + dc;
            const key = `${nr},${nc}`;

            if (nr >= 0 && nr < n && nc >= 0 && nc < n && lampLocations.has(key)) {
                const numLampsAtLocation = lampLocations.get(key);

                lampLocations.delete(key); // All lamps at this location are turned off

                rowCounts.set(nr, rowCounts.get(nr) - numLampsAtLocation);
                colCounts.set(nc, colCounts.get(nc) - numLampsAtLocation);
                diag1Counts.set(nr - nc, diag1Counts.get(nr - nc) - numLampsAtLocation);
                diag2Counts.set(nr + nc, diag2Counts.get(nr + nc) - numLampsAtLocation);
            }
        }
    }

    return results;
};