pub fn max_profit(prices: Vec<i32>, discount: i32) -> i32 {
    let mut max_profit = 0;
    let mut min_price = i32::MAX;

    for &price in &prices {
        min_price = min_price.min(price);
        max_profit = max_profit.max(price - min_price - discount);
    }

    max_profit
}