struct Solution;

impl Solution {
    pub fn min_partitions(s: String) -> i32 {
        s.chars().map(|c| c as i32 - '0' as i32).max().unwrap()
    }
}