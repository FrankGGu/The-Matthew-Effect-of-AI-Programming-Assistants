var minimumCost = function(horizontalCuts, verticalCuts) {
    horizontalCuts.sort((a, b) => b - a);
    verticalCuts.sort((a, b) => b - a);

    let totalCost = 0n;
    let horizontalPieces = 1n; // Represents the number of pieces formed horizontally
    let verticalPieces = 1n;   // Represents the number of pieces formed vertically

    let hPtr = 0;
    let vPtr = 0;

    while (hPtr < horizontalCuts.length && vPtr < verticalCuts.length) {
        const hCost = BigInt(horizontalCuts[hPtr]);
        const vCost = BigInt(verticalCuts[vPtr]);

        if (hCost >= vCost) {
            totalCost += hCost * verticalPieces;
            horizontalPieces++;
            hPtr++;
        } else {
            totalCost += vCost * horizontalPieces;
            verticalPieces++;
            vPtr++;
        }
    }

    // Process remaining horizontal cuts
    while (hPtr < horizontalCuts.length) {
        const hCost = BigInt(horizontalCuts[hPtr]);
        totalCost += hCost * verticalPieces;
        horizontalPieces++;
        hPtr++;
    }

    // Process remaining vertical cuts
    while (vPtr < verticalCuts.length) {
        const vCost = BigInt(verticalCuts[vPtr]);
        totalCost += vCost * horizontalPieces;
        verticalPieces++;
        vPtr++;
    }

    return Number(totalCost);
};