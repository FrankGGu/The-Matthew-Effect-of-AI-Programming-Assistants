function maxIceCream(costs, coins) {
    costs.sort((a, b) => a - b);
    let count = 0;
    for (let i = 0; i < costs.length && coins >= costs[i]; i++) {
        coins -= costs[i];
        count++;
    }
    return count;
}