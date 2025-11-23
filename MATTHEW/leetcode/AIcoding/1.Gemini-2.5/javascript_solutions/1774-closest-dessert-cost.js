var closestCost = function(baseCosts, toppingCosts, target) {
    let minDiff = Infinity;
    let result = Infinity;

    const allToppingSums = new Set();
    allToppingSums.add(0);

    for (const toppingCost of toppingCosts) {
        const currentSums = Array.from(allToppingSums);
        for (const sum of currentSums) {
            allToppingSums.add(sum + toppingCost);
            allToppingSums.add(sum + 2 * toppingCost);
        }
    }

    for (const base of baseCosts) {
        for (const toppingSum of allToppingSums) {
            const currentDessertCost = base + toppingSum;
            const currentDiff = Math.abs(currentDessertCost - target);

            if (currentDiff < minDiff) {
                minDiff = currentDiff;
                result = currentDessertCost;
            } else if (currentDiff === minDiff) {
                result = Math.min(result, currentDessertCost);
            }
        }
    }

    return result;
};