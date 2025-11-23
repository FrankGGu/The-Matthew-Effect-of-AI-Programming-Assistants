impl Solution {

use std::collections::HashSet;

struct Solution {}

impl Solution {
    pub fn distribute_candies(candy_type: Vec<i32>) -> i32 {
        let unique_types = candy_type.into_iter().collect::<HashSet<_>>();
        let max_types = unique_types.len() as i32;
        let max_eat = candy_type.len() as i32 / 2;
        std::cmp::min(max_types, max_eat)
    }
}
}