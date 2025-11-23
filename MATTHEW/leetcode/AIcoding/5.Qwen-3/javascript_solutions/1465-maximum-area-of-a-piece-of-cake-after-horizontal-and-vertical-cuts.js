function maxArea(h, w, horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => a - b);
    verticalCuts.sort((a, b) => a - b);

    let maxH = 0;
    let prev = 0;
    for (const cut of horizontalCuts) {
        maxH = Math.max(maxH, cut - prev);
        prev = cut;
    }
    maxH = Math.max(maxH, h - prev);

    let maxV = 0;
    prev = 0;
    for (const cut of verticalCuts) {
        maxV = Math.max(maxV, cut - prev);
        prev = cut;
    }
    maxV = Math.max(maxV, w - prev);

    return maxH * maxV;
}