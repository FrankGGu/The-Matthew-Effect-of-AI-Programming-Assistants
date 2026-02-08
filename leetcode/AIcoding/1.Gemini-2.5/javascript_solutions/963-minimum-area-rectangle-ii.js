var minAreaRect = function(points) {
    const N = points.length;
    if (N < 4) {
        return 0;
    }

    const pointSet = new Set();
    for (const p of points) {
        pointSet.add(`${p[0]},${p[1]}`);
    }

    let minArea = Infinity;

    for (let i = 0; i < N; i++) {
        const p1 = points[i];
        for (let j = i + 1; j < N; j++) {
            const p2 = points[j];
            for (let k = j + 1; k < N; k++) {
                const p3 = points[k];

                // Check P1 as the right angle vertex
                // Vector P1P2: (dx12, dy12)
                // Vector P1P3: (dx13, dy13)
                const dx12 = p2[0] - p1[0];
                const dy12 = p2[1] - p1[1];
                const dx13 = p3[0] - p1[0];
                const dy13 = p3[1] - p1[1];

                if (dx12 * dx13 + dy12 * dy13 === 0) { // P1P2 and P1P3 are orthogonal
                    // Fourth point P4 = P2 + (P3 - P1)
                    const p4x = p2[0] + p3[0] - p1[0];
                    const p4y = p2[1] + p3[1] - p1[1];
                    if (pointSet.has(`${p4x},${p4y}`)) {
                        const area = Math.sqrt(dx12 * dx12 + dy12 * dy12) * Math.sqrt(dx13 * dx13 + dy13 * dy13);
                        minArea = Math.min(minArea, area);
                    }
                }

                // Check P2 as the right angle vertex
                // Vector P2P1: (dx21, dy21)
                // Vector P2P3: (dx23, dy23)
                const dx21 = p1[0] - p2[0];
                const dy21 = p1[1] - p2[1];
                const dx23 = p3[0] - p2[0];
                const dy23 = p3[1] - p2[1];

                if (dx21 * dx23 + dy21 * dy23 === 0) { // P2P1 and P2P3 are orthogonal
                    // Fourth point P4 = P1 + (P3 - P2)
                    const p4x = p1[0] + p3[0] - p2[0];
                    const p4y = p1[1] + p3[1] - p2[1];
                    if (pointSet.has(`${p4x},${p4y}`)) {
                        const area = Math.sqrt(dx21 * dx21 + dy21 * dy21) * Math.sqrt(dx23 * dx23 + dy23 * dy23);
                        minArea = Math.min(minArea, area);
                    }
                }

                // Check P3 as the right angle vertex
                // Vector P3P1: (dx31, dy31)
                // Vector P3P2: (dx32, dy32)
                const dx31 = p1[0] - p3[0];
                const dy31 = p1[1] - p3[1];
                const dx32 = p2[0] - p3[0];
                const dy32 = p2[1] - p3[1];

                if (dx31 * dx32 + dy31 * dy32 === 0) { // P3P1 and P3P2 are orthogonal
                    // Fourth point P4 = P1 + (P2 - P3)
                    const p4x = p1[0] + p2[0] - p3[0];
                    const p4y = p1[1] + p2[1] - p3[1];
                    if (pointSet.has(`${p4x},${p4y}`)) {
                        const area = Math.sqrt(dx31 * dx31 + dy31 * dy31) * Math.sqrt(dx32 * dx32 + dy32 * dy32);
                        minArea = Math.min(minArea, area);
                    }
                }
            }
        }
    }

    return minArea === Infinity ? 0 : minArea;
};