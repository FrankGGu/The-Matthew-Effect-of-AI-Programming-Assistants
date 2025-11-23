var twoCityScheduling = function(costs) {
    costs.sort((a, b) => (a[0] - a[1]) - (b[0] - b[1]));
    let total = 0;
    for (let i = 0; i < costs.length; i++) {
        if (i < costs.length / 2) {
            total += costs[i][0];
        } else {
            total += costs[i][1];
        }
    }
    return total;
};