impl Solution {
    pub fn add_digits(num: i32) -> i32 {
        if num == 0 {
            return 0;
        }
        let digit_sum = num % 9;
        if digit_sum == 0 {
            9
        } else {
            digit_sum
        }
    }
}