var twoCitySchedCost = function(costs) {
    costs.sort((a, b) => (a[0] - a[1]) - (b[0] - b[1]));
    let n = costs.length / 2;
    let totalCost = 0;
    for (let i = 0; i < n; i++) {
        totalCost += costs[i][0] + costs[i + n][1];
    }
    return totalCost;
};