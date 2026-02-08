var maxIceCream = function(costs, coins) {
    costs.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < costs.length; i++) {
        if (coins >= costs[i]) {
            coins -= costs[i];
            count++;
        } else {
            break;
        }
    }
    return count;
};