impl Solution {
    pub fn largest_prime_substring_sum(s: String) -> i32 {
        let mut max_sum = 0;
        let mut current_sum = 0;
        let mut current_num = 0;

        for c in s.chars() {
            if c.is_digit(10) {
                let digit = c.to_digit(10).unwrap() as i32;
                current_num = current_num * 10 + digit;
                if Self::is_prime(current_num) {
                    current_sum += current_num;
                } else {
                    current_sum = 0;
                    current_num = digit;
                    if Self::is_prime(current_num) {
                        current_sum = current_num;
                    }
                }
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            } else {
                current_sum = 0;
                current_num = 0;
            }
        }

        max_sum
    }

    fn is_prime(n: i32) -> bool {
        if n <= 1 {
            return false;
        }
        if n == 2 {
            return true;
        }
        if n % 2 == 0 {
            return false;
        }
        let sqrt_n = (n as f64).sqrt() as i32;
        for i in (3..=sqrt_n).step_by(2) {
            if n % i == 0 {
                return false;
            }
        }
        true
    }
}