impl Solution {
    pub fn smallest_value_rearranged(num: i64) -> i64 {
        let mut digits: Vec<u32> = num.to_string().chars().map(|c| c.to_digit(10).unwrap()).collect();
        digits.sort();
        if digits[0] == 0 {
            let mut first_non_zero_index = 0;
            for i in 0..digits.len() {
                if digits[i] != 0 {
                    first_non_zero_index = i;
                    break;
                }
            }
            digits.swap(0, first_non_zero_index);
        }
        let mut result = 0;
        for &digit in &digits {
            result = result * 10 + digit as i64;
        }
        result
    }
}