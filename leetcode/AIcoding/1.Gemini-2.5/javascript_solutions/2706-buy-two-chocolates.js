var buyChocolates = function(prices, money) {
    prices.sort((a, b) => a - b);

    const minCost = prices[0] + prices[1];

    if (money >= minCost) {
        return money - minCost;
    } else {
        return money;
    }
};