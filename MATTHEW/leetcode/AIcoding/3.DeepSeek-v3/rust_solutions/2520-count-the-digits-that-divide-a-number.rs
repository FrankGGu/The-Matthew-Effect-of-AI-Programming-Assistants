impl Solution {
    pub fn count_digits(num: i32) -> i32 {
        let mut n = num;
        let mut count = 0;
        while n > 0 {
            let digit = n % 10;
            if digit != 0 && num % digit == 0 {
                count += 1;
            }
            n /= 10;
        }
        count
    }
}