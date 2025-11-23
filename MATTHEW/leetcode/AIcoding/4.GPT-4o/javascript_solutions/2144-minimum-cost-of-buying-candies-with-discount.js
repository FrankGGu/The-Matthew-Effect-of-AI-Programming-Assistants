function minimumCost(cost) {
    cost.sort((a, b) => a - b);
    let totalCost = 0;
    for (let i = 0; i < cost.length; i++) {
        if ((i + 1) % 3 !== 0) {
            totalCost += cost[i];
        }
    }
    return totalCost;
}