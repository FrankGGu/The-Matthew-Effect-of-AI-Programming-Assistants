var maxArea = function(h, w, horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => a - b);
    verticalCuts.sort((a, b) => a - b);

    let maxH = Math.max(horizontalCuts[0], h - horizontalCuts[horizontalCuts.length - 1]);
    for (let i = 1; i < horizontalCuts.length; i++) {
        maxH = Math.max(maxH, horizontalCuts[i] - horizontalCuts[i - 1]);
    }

    let maxW = Math.max(verticalCuts[0], w - verticalCuts[verticalCuts.length - 1]);
    for (let i = 1; i < verticalCuts.length; i++) {
        maxW = Math.max(maxW, verticalCuts[i] - verticalCuts[i - 1]);
    }

    const MOD = 10**9 + 7;
    return (BigInt(maxH) * BigInt(maxW)) % BigInt(MOD);
};