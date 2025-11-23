use std::collections::HashMap;

impl Solution {
    pub fn inventory_management(stock: Vec<i32>) -> i32 {
        let mut counts = HashMap::new();
        let n = stock.len() as i32;
        for &num in &stock {
            *counts.entry(num).or_insert(0) += 1;
            if counts[&num] > n / 2 {
                return num;
            }
        }
        0
    }
}