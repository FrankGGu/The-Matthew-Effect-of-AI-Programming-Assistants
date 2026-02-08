impl Solution {
    pub fn count_digit_one(n: i32) -> i32 {
        let mut count = 0;
        let mut factor = 1;
        let mut lower_numbers = 0;
        let mut current_digit = 0;

        while factor <= n {
            current_digit = (n / factor) % 10;
            lower_numbers = n - (n / factor) * factor;

            if current_digit == 0 {
                count += (n / (factor * 10)) * factor;
            } else if current_digit == 1 {
                count += (n / (factor * 10)) * factor + lower_numbers + 1;
            } else {
                count += (n / (factor * 10) + 1) * factor;
            }

            factor *= 10;
        }

        count
    }
}