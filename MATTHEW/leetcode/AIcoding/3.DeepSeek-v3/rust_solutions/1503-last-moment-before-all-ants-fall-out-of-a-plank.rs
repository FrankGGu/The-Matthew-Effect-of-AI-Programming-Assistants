impl Solution {
    pub fn get_last_moment(n: i32, left: Vec<i32>, right: Vec<i32>) -> i32 {
        let max_left = left.iter().max().copied().unwrap_or(0);
        let min_right = right.iter().min().copied().unwrap_or(n);
        max_left.max(n - min_right)
    }
}