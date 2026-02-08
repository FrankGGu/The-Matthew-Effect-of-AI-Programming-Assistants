var minCost = function(m, n, horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => a - b);
    verticalCuts.sort((a, b) => a - b);

    let maxH = Math.max(horizontalCuts[0], m - horizontalCuts[horizontalCuts.length - 1]);
    for (let i = 1; i < horizontalCuts.length; i++) {
        maxH = Math.max(maxH, horizontalCuts[i] - horizontalCuts[i - 1]);
    }

    let maxV = Math.max(verticalCuts[0], n - verticalCuts[verticalCuts.length - 1]);
    for (let i = 1; i < verticalCuts.length; i++) {
        maxV = Math.max(maxV, verticalCuts[i] - verticalCuts[i - 1]);
    }

    return (maxH * maxV) % (1e9 + 7);
};