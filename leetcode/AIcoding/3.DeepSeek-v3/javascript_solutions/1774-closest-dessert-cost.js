var closestCost = function(baseCosts, toppingCosts, target) {
    let closest = Infinity;

    const dfs = (index, currentCost) => {
        if (index === toppingCosts.length) {
            if (Math.abs(currentCost - target) < Math.abs(closest - target)) {
                closest = currentCost;
            } else if (Math.abs(currentCost - target) === Math.abs(closest - target)) {
                if (currentCost < closest) {
                    closest = currentCost;
                }
            }
            return;
        }

        // Option 0: do not take the topping
        dfs(index + 1, currentCost);
        // Option 1: take one of the topping
        dfs(index + 1, currentCost + toppingCosts[index]);
        // Option 2: take two of the topping
        dfs(index + 1, currentCost + 2 * toppingCosts[index]);
    };

    for (const base of baseCosts) {
        dfs(0, base);
    }

    return closest;
};