impl Solution {
    pub fn self_dividing_numbers(left: i32, right: i32) -> Vec<i32> {
        (left..=right).filter(|&num| {
            let mut n = num;
            while n > 0 {
                let digit = n % 10;
                if digit == 0 || num % digit != 0 {
                    return false;
                }
                n /= 10;
            }
            true
        }).collect()
    }
}