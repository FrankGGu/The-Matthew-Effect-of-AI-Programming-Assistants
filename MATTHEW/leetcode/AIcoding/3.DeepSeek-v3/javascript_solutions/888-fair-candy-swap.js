var fairCandySwap = function(aliceSizes, bobSizes) {
    const sumAlice = aliceSizes.reduce((a, b) => a + b, 0);
    const sumBob = bobSizes.reduce((a, b) => a + b, 0);
    const diff = (sumAlice - sumBob) / 2;
    const setAlice = new Set(aliceSizes);

    for (const candy of bobSizes) {
        if (setAlice.has(candy + diff)) {
            return [candy + diff, candy];
        }
    }

    return [];
};