var finalPrices = function(prices) {
    const n = prices.length;
    const result = new Array(n);
    for (let i = 0; i < n; i++) {
        result[i] = prices[i];
        for (let j = i + 1; j < n; j++) {
            if (prices[j] <= prices[i]) {
                result[i] = prices[i] - prices[j];
                break;
            }
        }
    }
    return result;
};