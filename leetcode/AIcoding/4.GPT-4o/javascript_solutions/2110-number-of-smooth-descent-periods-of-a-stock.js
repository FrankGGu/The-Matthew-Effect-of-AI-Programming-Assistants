var getDescentPeriods = function(prices) {
    let count = 0, length = 1;
    for (let i = 1; i < prices.length; i++) {
        if (prices[i] === prices[i - 1] - 1) {
            length++;
        } else {
            length = 1;
        }
        count += length;
    }
    return count + prices.length; // Adding the individual days
};