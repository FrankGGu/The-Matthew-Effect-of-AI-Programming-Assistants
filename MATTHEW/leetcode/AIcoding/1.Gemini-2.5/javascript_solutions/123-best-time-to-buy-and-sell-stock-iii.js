var maxProfit = function(prices) {
    if (prices.length === 0) {
        return 0;
    }

    // max_profit_k1_buy: maximum profit if we are holding the first stock
    // max_profit_k1_sell: maximum profit after completing the first transaction
    // max_profit_k2_buy: maximum profit if we are holding the second stock
    // max_profit_k2_sell: maximum profit after completing the second transaction

    // Initialize with values that represent no profit or a very large loss
    // A buy operation means we spend money, so profit decreases.
    // Initializing buy states to MIN_SAFE_INTEGER ensures that any actual buy operation
    // (which results in -price) will be greater than or equal to this initial value,
    // allowing the Math.max to correctly pick the first valid transaction.
    let max_profit_k1_buy = Number.MIN_SAFE_INTEGER;
    let max_profit_k1_sell = 0;
    let max_profit_k2_buy = Number.MIN_SAFE_INTEGER;
    let max_profit_k2_sell = 0;

    for (const price of prices) {
        // Update max_profit_k2_sell:
        // Option 1: Do nothing, keep previous max_profit_k2_sell.
        // Option 2: Sell the second stock at current 'price'. This requires having bought the second stock (max_profit_k2_buy).
        max_profit_k2_sell = Math.max(max_profit_k2_sell, max_profit_k2_buy + price);

        // Update max_profit_k2_buy:
        // Option 1: Do nothing, keep previous max_profit_k2_buy.
        // Option 2: Buy the second stock at current 'price'. This requires having completed the first transaction (max_profit_k1_sell).
        max_profit_k2_buy = Math.max(max_profit_k2_buy, max_profit_k1_sell - price);

        // Update max_profit_k1_sell:
        // Option 1: Do nothing, keep previous max_profit_k1_sell.
        // Option 2: Sell the first stock at current 'price'. This requires having bought the first stock (max_profit_k1_buy).
        max_profit_k1_sell = Math.max(max_profit_k1_sell, max_profit_k1_buy + price);

        // Update max_profit_k1_buy:
        // Option 1: Do nothing, keep previous max_profit_k1_buy.
        // Option 2: Buy the first stock at current 'price'. The profit becomes -price.
        max_profit_k1_buy = Math.max(max_profit_k1_buy, -price);
    }

    // The maximum profit after at most two transactions will be max_profit_k2_sell.
    return max_profit_k2_sell;
};