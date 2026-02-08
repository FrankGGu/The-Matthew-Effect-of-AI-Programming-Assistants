impl Solution {
    pub fn check_if_digits_are_equal_in_string_after_operations_ii(s: String) -> bool {
        let n = s.len();
        if n == 0 {
            return true;
        }

        let bytes = s.as_bytes();
        let mut new_digits: Vec<u8> = Vec::with_capacity(n / 2);

        for i in (0..n).step_by(2) {
            let digit1 = bytes[i] - b'0';
            let digit2 = bytes[i + 1] - b'0';
            let sum_mod_10 = (digit1 + digit2) % 10;
            new_digits.push(sum_mod_10);
        }

        if new_digits.is_empty() {
            return true;
        }

        let first_digit = new_digits[0];
        for &digit in new_digits.iter().skip(1) {
            if digit != first_digit {
                return false;
            }
        }

        true
    }
}