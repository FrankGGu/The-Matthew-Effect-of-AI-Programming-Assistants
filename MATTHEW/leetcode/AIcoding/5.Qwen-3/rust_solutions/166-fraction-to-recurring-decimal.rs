impl Solution {

use std::collections::HashMap;

impl Solution {
    pub fn fraction_to_decimal(numerator: i32, denominator: i32) -> String {
        if numerator == 0 {
            return "0".to_string();
        }

        let mut result = String::new();
        let mut num = numerator as i64;
        let den = denominator as i64;

        if (num < 0) ^ (den < 0) {
            result.push('-');
        }

        num = num.abs();
        let den = den.abs();

        let integer_part = num / den;
        result.push_str(&integer_part.to_string());

        let remainder = num % den;
        if remainder == 0 {
            return result;
        }

        result.push('.');

        let mut map = HashMap::new();
        let mut decimal_part = String::new();
        let mut remainder = remainder;

        while remainder != 0 {
            if let Some(index) = map.get(&remainder) {
                decimal_part.insert(*index as usize, '(');
                decimal_part.push(')');
                break;
            }

            map.insert(remainder, decimal_part.len());
            remainder *= 10;
            let digit = remainder / den;
            decimal_part.push((b'0' + digit as u8) as char);
            remainder %= den;
        }

        result.push_str(&decimal_part);
        result
    }
}
}