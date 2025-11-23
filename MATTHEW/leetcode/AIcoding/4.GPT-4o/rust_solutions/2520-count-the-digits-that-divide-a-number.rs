impl Solution {
    pub fn count_digits(num: i32) -> i32 {
        let mut count = 0;
        let mut n = num;

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