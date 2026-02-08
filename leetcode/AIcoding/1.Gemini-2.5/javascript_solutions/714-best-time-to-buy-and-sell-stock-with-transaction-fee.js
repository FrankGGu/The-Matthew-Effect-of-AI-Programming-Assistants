var maxProfit = function(prices, fee) {
    if (prices.length < 2) {
        return 0;
    }

    let hold = -prices[0]; // Maximum profit if we currently hold a stock
    let cash = 0;          // Maximum profit if we currently don't hold a stock

    for (let i = 1; i < prices.length; i++) {
        let prevHold = hold;
        let prevCash = cash;

        // Option 1: Continue holding (profit remains prevHold)
        // Option 2: Buy today (profit becomes prevCash - prices[i])
        hold = Math.max(prevHold, prevCash - prices[i]);

        // Option 1: Continue not holding (profit remains prevCash)
        // Option 2: Sell today (profit becomes prevHold + prices[i] - fee)
        cash = Math.max(prevCash, prevHold + prices[i] - fee);
    }

    return cash;
};