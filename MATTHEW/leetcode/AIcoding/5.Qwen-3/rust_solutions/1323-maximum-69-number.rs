struct Solution;

impl Solution {
    pub fn maximum69_number (num: i32) -> i32 {
        let mut num = num;
        let mut digits = Vec::new();

        while num > 0 {
            digits.push(num % 10);
            num /= 10;
        }

        for i in 0..digits.len() {
            if digits[i] == 6 {
                digits[i] = 9;
                break;
            }
        }

        let mut result = 0;
        for digit in digits {
            result = result * 10 + digit;
        }

        result
    }
}