function closestCost(baseCosts, toppingCosts, target) {
    let result = Infinity;

    function dfs(index, currentCost) {
        if (index === toppingCosts.length) {
            if (Math.abs(currentCost - target) < Math.abs(result - target)) {
                result = currentCost;
            } else if (Math.abs(currentCost - target) === Math.abs(result - target) && currentCost < result) {
                result = currentCost;
            }
            return;
        }

        for (let i = 0; i <= 3; i++) {
            dfs(index + 1, currentCost + i * toppingCosts[index]);
        }
    }

    for (const base of baseCosts) {
        dfs(0, base);
    }

    return result;
}