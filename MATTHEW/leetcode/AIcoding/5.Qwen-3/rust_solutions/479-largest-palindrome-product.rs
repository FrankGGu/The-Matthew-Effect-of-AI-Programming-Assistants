pub struct Solution {}

impl Solution {
    pub fn largest_palindrome(n: i32) -> i32 {
        if n == 1 {
            return 9;
        }

        let max = 10_i64.pow(n as u32) - 1;
        let min = 10_i64.pow(n as u32 - 1);

        for left in (min..=max).rev() {
            let mut right = left;
            let mut num = left;

            while right > 0 {
                num = num * 10 + right % 10;
                right /= 10;
            }

            for i in (min..=max).rev() {
                if num / i > max {
                    break;
                }
                if num % i == 0 {
                    return num as i32;
                }
            }
        }

        0
    }
}