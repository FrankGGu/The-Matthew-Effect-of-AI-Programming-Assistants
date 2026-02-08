impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut count = 0;
        let mut i = 1;
        while i <= n as i64 {
            let divider = i * 10;
            count += (n as i64 / divider) * i + std::cmp::min(std::cmp::max(n as i64 % divider - i + 1, 0), i);
            i *= 10;
        }
        count as i32
    }
}