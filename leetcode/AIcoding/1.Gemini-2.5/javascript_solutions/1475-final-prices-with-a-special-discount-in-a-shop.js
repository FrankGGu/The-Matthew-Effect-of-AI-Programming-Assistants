var finalPrices = function(prices) {
    const n = prices.length;
    const result = new Array(n);

    for (let i = 0; i < n; i++) {
        let discountFound = false;
        for (let j = i + 1; j < n; j++) {
            if (prices[j] <= prices[i]) {
                result[i] = prices[i] - prices[j];
                discountFound = true;
                break;
            }
        }
        if (!discountFound) {
            result[i] = prices[i];
        }
    }

    return result;
};