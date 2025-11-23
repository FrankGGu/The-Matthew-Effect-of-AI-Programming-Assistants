use std::collections::HashSet;

impl Solution {
    pub fn distribute_candies(candy_type: Vec<i32>) -> i32 {
        let unique_candies: HashSet<i32> = candy_type.into_iter().collect();
        let max_types = unique_candies.len() as i32;
        let half_length = (candy_type.len() / 2) as i32;

        if max_types > half_length {
            return half_length;
        } else {
            return max_types;
        }
    }
}