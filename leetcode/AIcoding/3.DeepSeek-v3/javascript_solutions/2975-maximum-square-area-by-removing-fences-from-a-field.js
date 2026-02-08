var maximizeSquareArea = function(m, n, hFences, vFences) {
    hFences.push(1, m);
    vFences.push(1, n);
    hFences.sort((a, b) => a - b);
    vFences.sort((a, b) => a - b);

    const hGaps = new Set();
    for (let i = 0; i < hFences.length; i++) {
        for (let j = i + 1; j < hFences.length; j++) {
            hGaps.add(hFences[j] - hFences[i]);
        }
    }

    const vGaps = new Set();
    for (let i = 0; i < vFences.length; i++) {
        for (let j = i + 1; j < vFences.length; j++) {
            vGaps.add(vFences[j] - vFences[i]);
        }
    }

    let maxArea = 0;
    for (const gap of hGaps) {
        if (vGaps.has(gap)) {
            maxArea = Math.max(maxArea, gap * gap);
        }
    }

    return maxArea === 0 ? -1 : maxArea % (1e9 + 7);
};