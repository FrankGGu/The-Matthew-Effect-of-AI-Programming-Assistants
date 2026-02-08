var maxIceCream = function(costs, coins) {
    costs.sort((a, b) => a - b);
    let count = 0;
    for (let cost of costs) {
        if (coins >= cost) {
            coins -= cost;
            count++;
        } else {
            break;
        }
    }
    return count;
};