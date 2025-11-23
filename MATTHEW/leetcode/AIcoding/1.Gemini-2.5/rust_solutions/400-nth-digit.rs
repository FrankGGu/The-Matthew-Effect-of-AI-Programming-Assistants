impl Solution {
    pub fn find_nth_digit(n: i32) -> i32 {
        let mut n_long = n as i64;
        let mut digits: i64 = 1;
        let mut count: i64 = 9;
        let mut start: i64 = 1;

        while n_long > digits * count {
            n_long -= digits * count;
            digits += 1;
            count *= 10;
            start *= 10;
        }

        n_long -= 1;

        let num_index = n_long / digits;
        let target_number = start + num_index;

        let digit_index_from_left = n_long % digits;

        let power_of_10 = digits - 1 - digit_index_from_left;
        let divisor = 10_i64.pow(power_of_10 as u32);

        ((target_number / divisor) % 10) as i32
    }
}