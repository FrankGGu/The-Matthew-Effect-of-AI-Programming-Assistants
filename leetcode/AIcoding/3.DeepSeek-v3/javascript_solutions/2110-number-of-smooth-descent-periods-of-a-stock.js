var getDescentPeriods = function(prices) {
    let total = 0;
    let current = 1;

    for (let i = 1; i < prices.length; i++) {
        if (prices[i] === prices[i - 1] - 1) {
            current++;
        } else {
            total += current * (current + 1) / 2;
            current = 1;
        }
    }
    total += current * (current + 1) / 2;

    return total;
};