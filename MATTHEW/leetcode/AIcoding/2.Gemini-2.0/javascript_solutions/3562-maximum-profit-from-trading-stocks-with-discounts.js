var maxProfit = function(prices, fee, discount) {
    let cash = 0;
    let hold = -prices[0];

    for (let i = 1; i < prices.length; i++) {
        let tempCash = cash;
        cash = Math.max(cash, hold + prices[i] - fee);
        hold = Math.max(hold, tempCash - prices[i] - discount);
    }

    return cash;
};