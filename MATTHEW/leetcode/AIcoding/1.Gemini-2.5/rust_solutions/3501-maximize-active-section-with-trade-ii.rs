impl Solution {
    pub fn max_profit(prices: Vec<i32>) -> i32 {
        let mut t1_cost = i32::MAX;
        let mut t1_profit = 0;
        let mut t2_cost = i32::MAX;
        let mut t2_profit = 0;

        for price in prices {
            // t1_cost: min cost to buy first stock
            t1_cost = t1_cost.min(price);
            // t1_profit: max profit after selling first stock
            t1_profit = t1_profit.max(price - t1_cost);

            // t2_cost: min cost to buy second stock, considering profit from first transaction
            // Effectively, price - t1_profit is the net money spent to acquire the second stock
            t2_cost = t2_cost.min(price - t1_profit);
            // t2_profit: max profit after selling second stock
            t2_profit = t2_profit.max(price - t2_cost);
        }

        t2_profit
    }
}