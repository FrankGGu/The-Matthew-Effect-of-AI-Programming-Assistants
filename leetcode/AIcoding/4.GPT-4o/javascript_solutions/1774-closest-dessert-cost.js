var closestCost = function(baseCosts, toppingCosts, target) {
    let closest = Infinity;

    const dfs = (index, currentCost) => {
        if (index === toppingCosts.length) {
            if (Math.abs(currentCost - target) < Math.abs(closest - target) || 
                (Math.abs(currentCost - target) === Math.abs(closest - target) && currentCost < closest)) {
                closest = currentCost;
            }
            return;
        }

        for (let i = 0; i <= 2; i++) {
            dfs(index + 1, currentCost + i * toppingCosts[index]);
        }
    };

    for (const base of baseCosts) {
        dfs(0, base);
    }

    return closest;
};