var maxProfit = function(prices) {
    let hold1 = -prices[0], hold2 = -prices[0];
    let release1 = 0, release2 = 0;

    for (let i = 1; i < prices.length; i++) {
        release2 = Math.max(release2, hold2 + prices[i]);
        hold2 = Math.max(hold2, release1 - prices[i]);
        release1 = Math.max(release1, hold1 + prices[i]);
        hold1 = Math.max(hold1, -prices[i]);
    }

    return release2;
};