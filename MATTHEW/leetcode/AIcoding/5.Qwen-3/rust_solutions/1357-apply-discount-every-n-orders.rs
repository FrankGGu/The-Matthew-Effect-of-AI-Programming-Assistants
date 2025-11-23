impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn apply_discount(orders: Vec<String>, n: i32, discount: i32) -> Vec<String> {
        let mut discount_applied = 0;
        let mut result = Vec::new();
        let mut order_count = 0;

        for order in orders {
            order_count += 1;
            if order_count % n == 0 {
                discount_applied += 1;
                let price: i32 = order
                    .split_whitespace()
                    .nth(1)
                    .unwrap()
                    .parse()
                    .unwrap();
                let discounted_price = price - (price * discount / 100);
                result.push(format!("{} {}", order.split_whitespace().next().unwrap(), discounted_price));
            } else {
                result.push(order);
            }
        }

        result
    }
}
}