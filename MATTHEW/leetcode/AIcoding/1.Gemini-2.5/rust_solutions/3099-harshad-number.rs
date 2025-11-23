impl Solution {
    pub fn sum_of_digits(mut n: i32) -> i32 {
        let mut sum = 0;
        while n > 0 {
            sum += n % 10;
            n /= 10;
        }
        sum
    }

    pub fn sum_of_digits_harshad_number(x: i32) -> i32 {
        let digit_sum = Self::sum_of_digits(x);
        if x % digit_sum == 0 {
            digit_sum
        } else {
            -1
        }
    }
}