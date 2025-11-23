impl Solution {
    pub fn sum_zero(n: i32) -> Vec<i32> {
        let mut result = Vec::new();
        for i in 0..n {
            result.push(i - (n / 2));
        }
        result
    }
}