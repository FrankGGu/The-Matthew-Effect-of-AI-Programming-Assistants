struct Solution;

impl Solution {
    pub fn sum_of_three(n: i64) -> Vec<i64> {
        if n % 3 != 0 {
            return vec![];
        }
        let x = n / 3 - 1;
        vec![x, x + 1, x + 2]
    }
}