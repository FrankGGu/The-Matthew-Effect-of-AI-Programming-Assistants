var getDescentPeriods = function(prices) {
    let n = prices.length;
    let count = 0;
    let len = 1;

    for (let i = 0; i < n; i++) {
        count += len;
        if (i + 1 < n && prices[i] - prices[i + 1] === 1) {
            len++;
        } else {
            len = 1;
        }
    }

    return count;
};