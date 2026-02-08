function buyChoco(prices, money) {
    prices.sort((a, b) => a - b);
    const minCost = prices[0] + prices[1];
    return money >= minCost ? money - minCost : money;
}