var fairCandySwap = function(aliceSizes, bobSizes) {
    let sumA = 0;
    for (let x of aliceSizes) {
        sumA += x;
    }

    let sumB = 0;
    const bobSet = new Set();
    for (let y of bobSizes) {
        sumB += y;
        bobSet.add(y);
    }

    // We want sumA - x + y = sumB - y + x
    // Rearranging: sumA - sumB = 2x - 2y
    // (sumA - sumB) / 2 = x - y
    // So, y = x - (sumA - sumB) / 2
    // Let diff = (sumA - sumB) / 2
    // Then y = x - diff

    const diff = (sumA - sumB) / 2;

    for (let x of aliceSizes) {
        const requiredY = x - diff;
        if (bobSet.has(requiredY)) {
            return [x, requiredY];
        }
    }
};