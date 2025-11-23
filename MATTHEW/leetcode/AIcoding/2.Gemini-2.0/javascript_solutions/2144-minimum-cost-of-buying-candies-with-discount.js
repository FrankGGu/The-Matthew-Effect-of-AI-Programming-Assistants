var minimumCost = function(cost) {
    cost.sort((a, b) => b - a);
    let minCost = 0;
    for (let i = 0; i < cost.length; i++) {
        if ((i + 1) % 3 !== 0) {
            minCost += cost[i];
        }
    }
    return minCost;
};