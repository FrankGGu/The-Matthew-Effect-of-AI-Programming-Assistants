var getMinDistSum = function(positions) {
    let left = 100, right = 0, bottom = 100, top = 0;
    for (const [x, y] of positions) {
        left = Math.min(left, x);
        right = Math.max(right, x);
        bottom = Math.min(bottom, y);
        top = Math.max(top, y);
    }

    let minX = left, maxX = right, minY = bottom, maxY = top;
    let minDist = Infinity;
    let bestX = 0, bestY = 0;

    const delta = 0.00001;
    const precision = 1e-6;

    while (maxX - minX > precision || maxY - minY > precision) {
        const midX = (minX + maxX) / 2;
        const midY = (minY + maxY) / 2;

        let dist = 0;
        for (const [x, y] of positions) {
            const dx = x - midX;
            const dy = y - midY;
            dist += Math.sqrt(dx * dx + dy * dy);
        }

        const candidates = [
            [midX - delta, midY - delta],
            [midX - delta, midY + delta],
            [midX + delta, midY - delta],
            [midX + delta, midY + delta]
        ];

        let foundBetter = false;
        for (const [cx, cy] of candidates) {
            let currentDist = 0;
            for (const [x, y] of positions) {
                const dx = x - cx;
                const dy = y - cy;
                currentDist += Math.sqrt(dx * dx + dy * dy);
            }
            if (currentDist < dist) {
                dist = currentDist;
                if (cx < midX) maxX = midX;
                else minX = midX;
                if (cy < midY) maxY = midY;
                else minY = midY;
                foundBetter = true;
                break;
            }
        }

        if (!foundBetter) {
            minX = midX - delta;
            maxX = midX + delta;
            minY = midY - delta;
            maxY = midY + delta;
        }
    }

    bestX = (minX + maxX) / 2;
    bestY = (minY + maxY) / 2;

    let totalDist = 0;
    for (const [x, y] of positions) {
        const dx = x - bestX;
        const dy = y - bestY;
        totalDist += Math.sqrt(dx * dx + dy * dy);
    }

    return totalDist;
};