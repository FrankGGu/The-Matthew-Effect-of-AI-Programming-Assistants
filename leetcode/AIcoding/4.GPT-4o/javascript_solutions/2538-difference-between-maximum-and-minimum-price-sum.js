var maximumDifference = function(prices) {
    let maxDiff = -1;
    let minPrice = prices[0];

    for (let i = 1; i < prices.length; i++) {
        if (prices[i] > minPrice) {
            maxDiff = Math.max(maxDiff, prices[i] - minPrice);
        } else {
            minPrice = prices[i];
        }
    }

    return maxDiff;
};