var closestCost = function(baseCosts, toppingCosts, target) {
    let closest = Infinity;

    function dfs(index, currentCost) {
        if (index === toppingCosts.length) {
            if (Math.abs(currentCost - target) < Math.abs(closest - target)) {
                closest = currentCost;
            } else if (Math.abs(currentCost - target) === Math.abs(closest - target)) {
                closest = Math.min(closest, currentCost);
            }
            return;
        }

        dfs(index + 1, currentCost);
        dfs(index + 1, currentCost + toppingCosts[index]);
        dfs(index + 1, currentCost + 2 * toppingCosts[index]);
    }

    for (const baseCost of baseCosts) {
        dfs(0, baseCost);
    }

    return closest;
};