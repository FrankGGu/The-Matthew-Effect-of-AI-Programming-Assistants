function minCostSetTime(current, maxTime) {
    const totalCost = (h, m) => h * 60 + m;
    const maxCost = Math.max(...current);

    let minCost = Infinity;

    for (let h = 0; h <= Math.floor(maxTime / 60); h++) {
        for (let m = 0; m < 60; m++) {
            if (totalCost(h, m) <= maxTime) {
                let cost = 0;
                for (let i = 0; i < current.length; i++) {
                    cost += Math.abs(current[i] - totalCost(h, m));
                }
                minCost = Math.min(minCost, cost);
            }
        }
    }

    return minCost === Infinity ? -1 : minCost;
}