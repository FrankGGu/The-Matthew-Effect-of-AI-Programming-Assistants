var maximizeSquareArea = function(n, m, hFences, vFences) {
    hFences.push(1);
    hFences.push(n);
    vFences.push(1);
    vFences.push(m);

    hFences.sort((a, b) => a - b);
    vFences.sort((a, b) => a - b);

    const hDiffs = new Set();
    for (let i = 0; i < hFences.length; i++) {
        for (let j = i + 1; j < hFences.length; j++) {
            hDiffs.add(Math.abs(hFences[i] - hFences[j]));
        }
    }

    const vDiffs = new Set();
    for (let i = 0; i < vFences.length; i++) {
        for (let j = i + 1; j < vFences.length; j++) {
            vDiffs.add(Math.abs(vFences[i] - vFences[j]));
        }
    }

    let maxArea = -1;
    for (const hDiff of hDiffs) {
        if (vDiffs.has(hDiff)) {
            maxArea = Math.max(maxArea, hDiff);
        }
    }

    if (maxArea === -1) {
        return -1;
    }

    const MOD = 10**9 + 7;
    return (BigInt(maxArea) * BigInt(maxArea)) % BigInt(MOD);
};