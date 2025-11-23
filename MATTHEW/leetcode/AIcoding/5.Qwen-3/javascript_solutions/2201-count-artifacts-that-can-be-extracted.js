function countArtifactsExtracted(n, artifacts, dig) {
    const digSet = new Set();
    for (const [x, y] of dig) {
        digSet.add(`${x},${y}`);
    }

    let count = 0;
    for (const [x1, y1, x2, y2] of artifacts) {
        let allCovered = true;
        for (let x = x1; x <= x2; x++) {
            for (let y = y1; y <= y2; y++) {
                if (!digSet.has(`${x},${y}`)) {
                    allCovered = false;
                    break;
                }
            }
            if (!allCovered) break;
        }
        if (allCovered) count++;
    }
    return count;
}