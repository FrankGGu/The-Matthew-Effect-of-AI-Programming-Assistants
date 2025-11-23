struct Solution;

impl Solution {
    pub fn count_assignments(n: i32) -> i32 {
        let mut result = 1;
        for i in 1..=n {
            result = result * (2 * i - 1) * i % 1000000007;
        }
        result
    }
}