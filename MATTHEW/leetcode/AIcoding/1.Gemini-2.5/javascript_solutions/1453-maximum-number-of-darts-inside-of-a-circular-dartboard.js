var numDarts = function(darts, r) {
    const n = darts.length;
    if (n === 0) {
        return 0;
    }
    if (n === 1) {
        return 1;
    }

    let maxDarts = 1;

    const rSq = r * r;
    const EPS = 1e-9;

    function distSq(p1, p2) {
        const dx = p1[0] - p2[0];
        const dy = p1[1] - p2[1];
        return dx * dx + dy * dy;
    }

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const p1 = darts[i];
            const p2 = darts[j];

            if (i === j) {
                let currentDarts = 0;
                for (let k = 0; k < n; k++) {
                    if (distSq(p1, darts[k]) <= rSq + EPS) {
                        currentDarts++;
                    }
                }
                maxDarts = Math.max(maxDarts, currentDarts);
                continue;
            }

            const dSq = distSq(p1, p2);

            if (dSq > 4 * rSq + EPS) {
                continue;
            }

            const d = Math.sqrt(dSq);
            const midX = (p1[0] + p2[0]) / 2;
            const midY = (p1[1] + p2[1]) / 2;

            const h = Math.sqrt(rSq - (d / 2) * (d / 2));

            const vx = p2[0] - p1[0];
            const vy = p2[1] - p1[1];

            const unitPerpVx = -vy / d;
            const unitPerpVy = vx / d;

            const center1 = [midX + h * unitPerpVx, midY + h * unitPerpVy];
            const center2 = [midX - h * unitPerpVx, midY - h * unitPerpVy];

            let currentDarts1 = 0;
            for (let k = 0; k < n; k++) {
                if (distSq(center1, darts[k]) <= rSq + EPS) {
                    currentDarts1++;
                }
            }
            maxDarts = Math.max(maxDarts, currentDarts1);

            let currentDarts2 = 0;
            for (let k = 0; k < n; k++) {
                if (distSq(center2, darts[k]) <= rSq + EPS) {
                    currentDarts2++;
                }
            }
            maxDarts = Math.max(maxDarts, currentDarts2);
        }
    }

    return maxDarts;
};