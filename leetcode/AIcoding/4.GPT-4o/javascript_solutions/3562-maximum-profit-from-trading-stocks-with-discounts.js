function maxProfit(prices, discount) {
    let n = prices.length;
    if (n === 0) return 0;

    let minPrice = prices[0];
    let maxProfit = 0;

    for (let i = 1; i < n; i++) {
        if (prices[i] < minPrice) {
            minPrice = prices[i];
        } else {
            let discountedPrice = prices[i] - discount;
            maxProfit = Math.max(maxProfit, discountedPrice - minPrice);
        }
    }

    return maxProfit;
}