impl Solution {
    pub fn count_digits(num: i32) -> i32 {
        let mut count = 0;
        let mut temp_num = num;

        while temp_num > 0 {
            let digit = temp_num % 10;
            if digit != 0 && num % digit == 0 {
                count += 1;
            }
            temp_num /= 10;
        }

        count
    }
}