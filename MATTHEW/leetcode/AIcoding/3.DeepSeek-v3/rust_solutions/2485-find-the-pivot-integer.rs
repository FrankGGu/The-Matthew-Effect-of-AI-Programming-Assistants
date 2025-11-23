impl Solution {
    pub fn pivot_integer(n: i32) -> i32 {
        let total_sum = n * (n + 1) / 2;
        let mut sum = 0;
        for x in 1..=n {
            sum += x;
            if sum == total_sum - sum + x {
                return x;
            }
        }
        -1
    }
}