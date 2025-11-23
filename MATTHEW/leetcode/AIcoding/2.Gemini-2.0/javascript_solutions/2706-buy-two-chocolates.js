var buyChoco = function(prices, money) {
    prices.sort((a, b) => a - b);
    if (prices[0] + prices[1] <= money) {
        return money - (prices[0] + prices[1]);
    } else {
        return money;
    }
};