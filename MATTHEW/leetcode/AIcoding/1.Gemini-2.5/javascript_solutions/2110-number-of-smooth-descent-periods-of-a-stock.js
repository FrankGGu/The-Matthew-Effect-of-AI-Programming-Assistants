var smoothDescentPeriods = function(prices) {
    if (prices.length === 0) {
        return 0;
    }

    let totalSmoothPeriods = 0;
    let currentDescentLength = 0;

    for (let i = 0; i < prices.length; i++) {
        if (i === 0 || prices[i - 1] - prices[i] === 1) {
            currentDescentLength++;
        } else {
            currentDescentLength = 1;
        }
        totalSmoothPeriods += currentDescentLength;
    }

    return totalSmoothPeriods;
};