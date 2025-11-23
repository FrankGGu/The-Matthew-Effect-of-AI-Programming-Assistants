impl Solution {
    pub fn kids_with_candies(candies: Vec<i32>, extra_candies: i32) -> Vec<bool> {
        let max_candies = *candies.iter().max().unwrap();
        candies.iter().map(|&c| c + extra_candies >= max_candies).collect()
    }
}