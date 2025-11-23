var maxArea = function(h, w, horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => a - b);
    verticalCuts.sort((a, b) => a - b);

    let maxDx = 0;
    let prevX = 0;
    for (const cut of horizontalCuts) {
        maxDx = Math.max(maxDx, cut - prevX);
        prevX = cut;
    }
    maxDx = Math.max(maxDx, h - prevX);

    let maxDy = 0;
    let prevY = 0;
    for (const cut of verticalCuts) {
        maxDy = Math.max(maxDy, cut - prevY);
        prevY = cut;
    }
    maxDy = Math.max(maxDy, w - prevY);

    const MOD = 1000000007;
    return (BigInt(maxDx) * BigInt(maxDy)) % BigInt(MOD);
};