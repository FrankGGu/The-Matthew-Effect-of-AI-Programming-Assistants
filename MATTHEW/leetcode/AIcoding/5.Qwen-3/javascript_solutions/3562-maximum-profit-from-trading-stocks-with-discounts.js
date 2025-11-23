function maxProfit(prices) {
    const n = prices.length;
    let total = 0;
    for (let i = 1; i < n; i++) {
        if (prices[i] < prices[i - 1]) {
            total += prices[i - 1] - prices[i];
        }
    }
    return total;
}