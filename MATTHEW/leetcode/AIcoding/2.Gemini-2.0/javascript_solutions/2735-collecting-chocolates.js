var maximizeTheNumberOfChocolates = function(costs, money) {
    costs.sort((a, b) => a - b);
    let count = 0;
    let sum = 0;
    for (let i = 0; i < costs.length; i++) {
        if (sum + costs[i] <= money) {
            sum += costs[i];
            count++;
        } else {
            break;
        }
    }
    return count;
};