var maxProfit = function(prices) {
    if (prices.length <= 1) return 0;

    let hold = -prices[0];
    let cooldown = 0;
    let sell = 0;

    for (let i = 1; i < prices.length; i++) {
        let prevHold = hold;
        let prevCooldown = cooldown;
        let prevSell = sell;

        hold = Math.max(prevHold, prevCooldown - prices[i]);
        sell = prevHold + prices[i];
        cooldown = Math.max(prevCooldown, prevSell);
    }

    return Math.max(sell, cooldown);
};