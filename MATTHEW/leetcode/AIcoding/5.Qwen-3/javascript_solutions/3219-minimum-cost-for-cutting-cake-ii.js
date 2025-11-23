function minCost(h, w, horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => a - b);
    verticalCuts.sort((a, b) => a - b);

    let maxH = 0;
    let prev = 0;
    for (let i = 0; i < horizontalCuts.length; i++) {
        maxH = Math.max(maxH, horizontalCuts[i] - prev);
        prev = horizontalCuts[i];
    }
    maxH = Math.max(maxH, h - prev);

    let maxW = 0;
    prev = 0;
    for (let i = 0; i < verticalCuts.length; i++) {
        maxW = Math.max(maxW, verticalCuts[i] - prev);
        prev = verticalCuts[i];
    }
    maxW = Math.max(maxW, w - prev);

    return (maxH * maxW) % (10**9 + 7);
}