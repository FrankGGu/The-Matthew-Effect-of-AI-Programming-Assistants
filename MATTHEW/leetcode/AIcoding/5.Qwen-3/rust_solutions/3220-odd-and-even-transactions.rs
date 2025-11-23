impl Solution {

use std::collections::HashMap;

struct Solution;

impl Solution {
    pub fn odd_even_transactions(transactions: Vec<String>) -> HashMap<String, i32> {
        let mut result = HashMap::new();

        for transaction in transactions {
            let parts: Vec<&str> = transaction.split(',').collect();
            if parts.len() < 2 {
                continue;
            }
            let name = parts[0];
            let amount = parts[1].parse::<i32>().unwrap_or(0);

            if amount % 2 == 1 {
                *result.entry(name.to_string()).or_insert(0) += amount;
            }
        }

        result
    }
}
}