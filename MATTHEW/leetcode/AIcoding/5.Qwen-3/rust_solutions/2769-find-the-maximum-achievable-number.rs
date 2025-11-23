struct Solution;

impl Solution {
    pub fn the_maximum_achievable_number(mut num: i32, mut change: i32) -> i32 {
        while change > 0 {
            let digit = num % 10;
            if digit < 9 {
                num += 10 - digit;
                change -= 1;
            } else {
                num /= 10;
            }
        }
        num
    }
}