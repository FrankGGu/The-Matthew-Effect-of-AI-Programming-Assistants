impl Solution {
    pub fn sum_of_three_consecutive_integers(n: i32) -> Vec<i32> {
        if n % 3 == 0 {
            return vec![n / 3 - 1, n / 3, n / 3 + 1];
        }
        Vec::new()
    }
}