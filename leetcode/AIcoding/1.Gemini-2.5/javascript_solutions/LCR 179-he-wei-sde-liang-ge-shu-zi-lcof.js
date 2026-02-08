var twoSum = function(prices, target) {
    const seenPrices = new Set();

    for (const price of prices) {
        const complement = target - price;
        if (seenPrices.has(complement)) {
            return [complement, price];
        }
        seenPrices.add(price);
    }
    return [];
};