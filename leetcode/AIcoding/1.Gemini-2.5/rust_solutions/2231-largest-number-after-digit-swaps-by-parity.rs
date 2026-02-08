impl Solution {
    pub fn largest_integer(num: i32) -> i32 {
        let mut original_digits = Vec::new();
        let mut temp_num = num;

        if temp_num == 0 {
            return 0;
        }

        while temp_num > 0 {
            original_digits.push(temp_num % 10);
            temp_num /= 10;
        }
        original_digits.reverse();

        let mut odd_digits = Vec::new();
        let mut even_digits = Vec::new();

        for &digit in &original_digits {
            if digit % 2 == 0 {
                even_digits.push(digit);
            } else {
                odd_digits.push(digit);
            }
        }

        odd_digits.sort_unstable_by(|a, b| b.cmp(a));
        even_digits.sort_unstable_by(|a, b| b.cmp(a));

        let mut result = 0;
        let mut odd_idx = 0;
        let mut even_idx = 0;

        for &digit in &original_digits {
            result *= 10;
            if digit % 2 == 0 {
                result += even_digits[even_idx];
                even_idx += 1;
            } else {
                result += odd_digits[odd_idx];
                odd_idx += 1;
            }
        }

        result
    }
}