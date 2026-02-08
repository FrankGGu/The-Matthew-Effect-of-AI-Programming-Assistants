var maxBuilding = function(n, restrictions) {
    const restrictionMap = new Map();
    restrictionMap.set(1, 0);

    for (const [pos, height] of restrictions) {
        restrictionMap.set(pos, Math.min(restrictionMap.get(pos) === undefined ? Infinity : restrictionMap.get(pos), height));
    }

    restrictionMap.set(n, Math.min(restrictionMap.get(n) === undefined ? Infinity : restrictionMap.get(n), n - 1));

    const sortedRestrictions = Array.from(restrictionMap.entries()).sort((a, b) => a[0] - b[0]);

    for (let i = 1; i < sortedRestrictions.length; i++) {
        const [prevPos, prevHeight] = sortedRestrictions[i - 1];
        const [currPos, currHeight] = sortedRestrictions[i];
        sortedRestrictions[i][1] = Math.min(currHeight, prevHeight + (currPos - prevPos));
    }

    for (let i = sortedRestrictions.length - 2; i >= 0; i--) {
        const [currPos, currHeight] = sortedRestrictions[i];
        const [nextPos, nextHeight] = sortedRestrictions[i + 1];
        sortedRestrictions[i][1] = Math.min(currHeight, nextHeight + (nextPos - currPos));
    }

    let maxHeight = 0;
    for (let i = 0; i < sortedRestrictions.length - 1; i++) {
        const [p1, h1] = sortedRestrictions[i];
        const [p2, h2] = sortedRestrictions[i + 1];
        const diff = p2 - p1;

        const peakHeight = Math.max(h1, h2) + Math.floor((diff - Math.abs(h1 - h2)) / 2);
        maxHeight = Math.max(maxHeight, peakHeight);
    }

    return maxHeight;
};