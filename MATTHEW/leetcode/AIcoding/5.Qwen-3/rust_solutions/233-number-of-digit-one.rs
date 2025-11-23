struct Solution;

impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut count = 0;
        let mut i = 1;
        while i <= n {
            let divider = i * 10;
            count += (n / divider) * i;
            let remainder = n % divider;
            if remainder >= i * 2 {
                count += i;
            } else if remainder >= i {
                count += remainder - i + 1;
            }
            i *= 10;
        }
        count
    }
}