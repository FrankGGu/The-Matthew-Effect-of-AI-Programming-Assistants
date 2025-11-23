impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut count = 0;
        let mut i = 1;
        let n = n as i64;
        while i <= n {
            let divisor = i * 10;
            count += (n / divisor) * i + std::cmp::min(std::cmp::max(n % divisor - i + 1, 0), i);
            i *= 10;
        }
        count as i32
    }
}