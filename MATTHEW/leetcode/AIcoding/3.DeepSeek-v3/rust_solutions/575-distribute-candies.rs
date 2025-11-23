use std::collections::HashSet;

impl Solution {
    pub fn distribute_candies(candy_type: Vec<i32>) -> i32 {
        let unique_candies: HashSet<_> = candy_type.iter().collect();
        let max_allowed = candy_type.len() / 2;
        unique_candies.len().min(max_allowed) as i32
    }
}