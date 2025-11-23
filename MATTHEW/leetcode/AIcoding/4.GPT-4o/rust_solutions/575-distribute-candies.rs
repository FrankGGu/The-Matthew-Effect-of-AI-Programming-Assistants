impl Solution {
    pub fn distribute_candies(candy_type: Vec<i32>) -> i32 {
        let unique_candies = candy_type.into_iter().collect::<std::collections::HashSet<_>>().len();
        let max_candies = candy_type.len() / 2;
        unique_candies.min(max_candies) as i32
    }
}