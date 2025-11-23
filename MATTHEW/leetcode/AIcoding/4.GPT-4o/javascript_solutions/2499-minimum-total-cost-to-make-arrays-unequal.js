var minimumTotalCost = function(n, cost) {
    let totalCost = 0;
    let freq = new Map();

    for (let i = 0; i < n; i++) {
        if (freq.has(cost[i])) {
            freq.set(cost[i], freq.get(cost[i]) + 1);
            if (freq.get(cost[i]) === 2) {
                totalCost += cost[i] / 2;
            }
        } else {
            freq.set(cost[i], 1);
        }
    }

    return totalCost;
};