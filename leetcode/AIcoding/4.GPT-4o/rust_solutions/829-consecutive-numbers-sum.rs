impl Solution {
    pub fn consecutive_numbers_sum(n: i32) -> i32 {
        let mut count = 0;
        for k in 1..=((2 * n) as f64).sqrt() as i32 {
            if (n - k * (k + 1) / 2) % k == 0 && (n - k * (k + 1) / 2) >= 0 {
                count += 1;
            }
        }
        count
    }
}