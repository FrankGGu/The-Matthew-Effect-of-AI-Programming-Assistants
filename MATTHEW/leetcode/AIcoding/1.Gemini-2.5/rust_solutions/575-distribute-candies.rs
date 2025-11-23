use std::collections::HashSet;

impl Solution {
    pub fn distribute_candies(candies: Vec<i32>) -> i32 {
        let max_candies_to_eat = candies.len() / 2;
        let mut unique_types = HashSet::new();

        for candy_type in candies {
            unique_types.insert(candy_type);
        }

        (unique_types.len() as i32).min(max_candies_to_eat as i32)
    }
}