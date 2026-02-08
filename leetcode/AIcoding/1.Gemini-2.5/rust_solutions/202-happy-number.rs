use std::collections::HashSet;

impl Solution {
    pub fn is_happy(n: i32) -> bool {
        let mut seen = HashSet::new();
        let mut current_n = n;

        while current_n != 1 && !seen.contains(&current_n) {
            seen.insert(current_n);
            let mut sum_of_squares = 0;
            let mut temp_n = current_n;

            while temp_n > 0 {
                let digit = temp_n % 10;
                sum_of_squares += digit * digit;
                temp_n /= 10;
            }
            current_n = sum_of_squares;
        }

        current_n == 1
    }
}