var minimumCost = function(horizontalCut, verticalCut) {
    horizontalCut.sort((a, b) => b - a);
    verticalCut.sort((a, b) => b - a);

    let totalCost = 0;
    let horizontalPieces = 1;
    let verticalPieces = 1;

    let hPtr = 0;
    let vPtr = 0;

    while (hPtr < horizontalCut.length && vPtr < verticalCut.length) {
        if (horizontalCut[hPtr] >= verticalCut[vPtr]) {
            totalCost += horizontalCut[hPtr] * verticalPieces;
            horizontalPieces++;
            hPtr++;
        } else {
            totalCost += verticalCut[vPtr] * horizontalPieces;
            verticalPieces++;
            vPtr++;
        }
    }

    while (hPtr < horizontalCut.length) {
        totalCost += horizontalCut[hPtr] * verticalPieces;
        horizontalPieces++;
        hPtr++;
    }

    while (vPtr < verticalCut.length) {
        totalCost += verticalCut[vPtr] * horizontalPieces;
        verticalPieces++;
        vPtr++;
    }

    return totalCost;
};