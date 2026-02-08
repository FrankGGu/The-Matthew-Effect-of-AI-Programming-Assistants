var maxProfit = function(prices) {
    if (prices.length === 0) {
        return 0;
    }

    let n = prices.length;

    // prevHold: maximum profit if we are holding a stock at the end of the previous day.
    // prevSold: maximum profit if we just sold a stock at the end of the previous day.
    // prevRest: maximum profit if we are in a cooldown/rest state at the end of the previous day.

    // Initialize for day 0
    let prevHold = -prices[0]; // Buy on day 0
    let prevSold = -Infinity;  // Cannot sell on day 0
    let prevRest = 0;          // Initial state: no stock, no profit, ready to buy

    for (let i = 1; i < n; i++) {
        // Calculate current day's states based on previous day's states
        let currHold = Math.max(prevHold, prevRest - prices[i]);
        let currSold = prevHold + prices[i];
        let currRest = Math.max(prevRest, prevSold);

        // Update previous day's states for the next iteration
        prevHold = currHold;
        prevSold = currSold;
        prevRest = currRest;
    }

    // The maximum profit must be from a state where we do not hold a stock.
    // This can be either after selling or after resting.
    return Math.max(prevSold, prevRest);
};