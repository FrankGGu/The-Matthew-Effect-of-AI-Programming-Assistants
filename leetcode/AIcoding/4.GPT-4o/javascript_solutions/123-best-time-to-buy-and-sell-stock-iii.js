var maxProfit = function(prices) {
    let n = prices.length;
    if (n < 2) return 0;

    let firstBuy = -Infinity, firstSell = 0;
    let secondBuy = -Infinity, secondSell = 0;

    for (let price of prices) {
        firstBuy = Math.max(firstBuy, -price);
        firstSell = Math.max(firstSell, firstBuy + price);
        secondBuy = Math.max(secondBuy, firstSell - price);
        secondSell = Math.max(secondSell, secondBuy + price);
    }

    return secondSell;
};