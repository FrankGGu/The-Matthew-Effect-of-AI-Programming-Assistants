impl Solution {
    pub fn alternate_digit_sum(n: i32) -> i32 {
        let mut sum = 0;
        let mut sign = 1;
        let mut num = n;

        while num > 0 {
            sum += sign * (num % 10);
            sign *= -1;
            num /= 10;
        }

        sum
    }
}