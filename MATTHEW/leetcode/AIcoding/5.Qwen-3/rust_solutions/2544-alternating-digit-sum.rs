struct Solution;

impl Solution {
    pub fn alternate_digit_sum(n: i32) -> i32 {
        let mut result = 0;
        let mut sign = 1;
        let mut num = n.abs();

        while num > 0 {
            result += sign * (num % 10);
            sign *= -1;
            num /= 10;
        }

        result
    }
}